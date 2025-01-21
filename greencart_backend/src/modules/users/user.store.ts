import { Service } from "typedi";
import { FilterQuery, Types } from 'mongoose';

import { IUser, User } from "./user";

@Service("user.store")
export class UserStore{
    
    async get(filter:FilterQuery<IUser>):Promise<IUser|null>{
        return await User.findOne(filter)
    }

    async findById(id: string){
        return await User.findById(id);
    }

    async create(partial:Partial<IUser>):Promise<IUser>{
        const user = new User(partial)
        await user.save()
        return user
    }

    async update(_id:string,partial:Partial<IUser>):Promise<IUser|null>{
        const user = await User.findOneAndUpdate({_id:new Types.ObjectId(_id)},partial)
        return user
    }

    async getOneByAtLeastOneCondition(filters:FilterQuery<IUser>[]):Promise<IUser|null>{
        const user = await  User.findOne({$or:filters})
        return user
    }

    async queryOne(params:{equ?:{title:string,val:string}}):Promise<IUser>{
        let query = User.find();
        query.setOptions({ lean : true });
        if(params.equ) query = query.where(params.equ.title).equals(params.equ.val)
        const result = await query.exec()
        return result[0]
    }

}