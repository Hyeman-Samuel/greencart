import { Inject, Service } from "typedi";
import { BadRequestError, NotFoundError } from "routing-controllers";

import { UserStore } from "./user.store";
import { IUser } from './user';
import jwt from 'jsonwebtoken'
import { environment } from "../../infra/environment";



@Service("user.service")
export class UserService {
    constructor(
        @Inject("user.store") private readonly userStore: UserStore,
    ) { }


    async findUniqueOrFail(filter: Partial<IUser>): Promise<IUser> {
        const user = await this.userStore.get(filter)
        if (!user) throw new NotFoundError("User Not Found")
        return user
    }


    async findUnique(filter: Partial<IUser>): Promise<IUser | null> {
        const user = await this.userStore.get(filter)
        return user
    }

    async getUserById(id: string){
        return this.userStore.findById(id)
    }

    async createUser(partial: Partial<IUser>): Promise<IUser> {
        const user = await this.userStore.create(partial)
        if (!user) throw new BadRequestError("User creation failed");

        // let { otp } = await this.userStore.createUserOTP(user._id)
        // this.messagingService.sendMail(user.email, "Verify your email", `Your OTP is: ${otp}`)
        return user
    }

    async updateUser(id: string, partial: Partial<IUser>): Promise<IUser> {
        const user = await this.userStore.update(id, partial)
        if (!user) throw new BadRequestError("User update failed")
        return user
    }

    async findUser(username: string): Promise<IUser | null> {
        const user = await this.userStore.getOneByAtLeastOneCondition([{ username }, { email: username }])
        return user
    }

    createUserToken(user: IUser) {
        return jwt.sign({ _id: user._id, email: user.email}, environment.jwt.secret)
    }

    verifyUserToken(token: string): { _id: string, email: string}{
        return jwt.verify(token, environment.jwt.secret) as { _id: string, email: string}
    }
}