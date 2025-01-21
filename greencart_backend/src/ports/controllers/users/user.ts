import { BadRequestError, Body, Get, JsonController, Post, Req, Res, UseBefore } from "routing-controllers";
import { Inject, Service } from "typedi";
import bcrypt from 'bcryptjs'
import { Response } from 'express'
import { OpenAPI } from "routing-controllers-openapi";

import { UserService } from "../../../modules/users";
import { AuthMiddleware } from "../../middlewares/auth.middleware";
import { LoginDto, UserModel } from "./user.model";


@JsonController('/users')
@Service()
export class UserController {

    constructor(
        @Inject("user.service") private readonly userService: UserService,
    ) { }


    @Post('/')
    async registerUser(@Body() input: UserModel, @Res() res: Response){
        if(await this.userService.findUnique({ email: input.email }))
            throw new BadRequestError("user already exists")

        input.password = await bcrypt.hashSync(input.password, 10);
        let response = await this.userService.createUser({ ...input });
        return res.status(201).json({ user: response,token: await this.userService.createUserToken(response) })
    }

    @Post('/login')
    async loginUser(@Body() input: LoginDto, @Res() res: Response){
        let { email, password } = input;
        let user = await this.userService.findUnique({ email })
        if(!user) throw new BadRequestError("invalid credentials")

        if(!await bcrypt.compareSync(password, user.password)) throw new BadRequestError("invalid credentials")
        
        return res.json({ user, token: this.userService.createUserToken(user) })
    }

    @Get('/profile')
    @OpenAPI({ security: [{ bearerAuth: [] }] })
    @UseBefore(AuthMiddleware)
    async viewUserProfile(@Req() req: any, @Res() res: Response){
        let user = await this.userService.findUnique({ _id: req.user._id })
        return res.json({ user });
    }

}