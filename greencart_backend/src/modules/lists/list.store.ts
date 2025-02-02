import { Service } from "typedi";
import { FilterQuery, Types } from 'mongoose';

import { IList, List } from "./list";

@Service("list.store")
export class ListStore{
    
    async get(filter:FilterQuery<IList>):Promise<IList|null>{
        return await List.findOne(filter)
    }

    async getAll(filter:FilterQuery<IList>):Promise<IList[]>{
        return await List.find(filter)
    }

    async findById(id: string){
        return await List.findById(id);
    }

    async create(partial:Partial<IList>):Promise<IList>{
        const list = new List(partial)
        await list.save()
        return list
    }

    async update(_id:string,partial:Partial<IList>):Promise<IList|null>{
        const list = await List.findOneAndUpdate({_id:new Types.ObjectId(_id)},partial)
        return list
    }

    async delete(_id:string):Promise<boolean>{
        const list = await List.deleteOne({_id:new Types.ObjectId(_id)})
        return list.acknowledged
    }

    async getOneByAtLeastOneCondition(filters:FilterQuery<IList>[]):Promise<IList|null>{
        const list = await  List.findOne({$or:filters})
        return list
    }

    async queryOne(params:{equ?:{title:string,val:string}}):Promise<IList>{
        let query = List.find();
        query.setOptions({ lean : true });
        if(params.equ) query = query.where(params.equ.title).equals(params.equ.val)
        const result = await query.exec()
        return result[0]
    }

}