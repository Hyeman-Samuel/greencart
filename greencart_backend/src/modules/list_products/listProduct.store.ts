import { Service } from "typedi";
import { FilterQuery, Types } from 'mongoose';

import { IListProduct, ListProduct } from "./listProduct";

@Service("listProduct.store")
export class ListProductStore{
    
    async get(filter:FilterQuery<IListProduct>):Promise<IListProduct|null>{
        return await ListProduct.findOne(filter)
    }

    async getAll(filter:FilterQuery<IListProduct>):Promise<IListProduct[]>{
        return await ListProduct.find(filter).populate("product").select("-list")
    }

    async findById(id: string){
        return await ListProduct.findById(id);
    }

    async create(partial:Partial<IListProduct>):Promise<IListProduct>{
        const list_product = new ListProduct(partial)
        await list_product.save()
        return list_product
    }

    async update(_id:string,partial:Partial<IListProduct>):Promise<IListProduct|null>{
        const list_product = await ListProduct.findOneAndUpdate({_id:new Types.ObjectId(_id)},partial)
        return list_product
    }

    async getOneByAtLeastOneCondition(filters:FilterQuery<IListProduct>[]):Promise<IListProduct|null>{
        const list_product = await  ListProduct.findOne({$or:filters})
        return list_product
    }

    async queryOne(params:{equ?:{title:string,val:string}}):Promise<IListProduct>{
        let query = ListProduct.find();
        query.setOptions({ lean : true });
        if(params.equ) query = query.where(params.equ.title).equals(params.equ.val)
        const result = await query.exec()
        return result[0]
    }

    async delete(_id:string):Promise<boolean>{
        await ListProduct.deleteOne({_id:new Types.ObjectId(_id)})
        return true
    }

}