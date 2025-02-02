import { Service } from "typedi";
import { FilterQuery, RootFilterQuery, Types } from 'mongoose';

import { IProduct, Product } from "./product";

@Service("product.store")
export class ProductStore{
    
    async get(filter:FilterQuery<IProduct>):Promise<IProduct|null>{
        return await Product.findOne(filter)
    }

    async getAll(filter:FilterQuery<IProduct>,_skip:number=0,_limit:number=15):Promise<IProduct[]>{
        return await Product.find(filter).skip(_skip).limit(_limit)
    }

    async findById(id: string){
        return await Product.findById(id);
    }

    async create(partial:Partial<IProduct>):Promise<IProduct>{
        const product = new Product(partial)
        await product.save()
        return product
    }

    async update(_id:string,partial:Partial<IProduct>):Promise<IProduct|null>{
        const product = await Product.findOneAndUpdate({_id:new Types.ObjectId(_id)},partial)
        return product
    }

    async getOneByAtLeastOneCondition(filters:FilterQuery<IProduct>[]):Promise<IProduct|null>{
        const product = await  Product.findOne({$or:filters})
        return product
    }

    async queryOne(params:{equ?:{title:string,val:string}}):Promise<IProduct>{
        let query = Product.find();
        query.setOptions({ lean : true });
        if(params.equ) query = query.where(params.equ.title).equals(params.equ.val)
        const result = await query.exec()
        return result[0]
    }
    async query(body:RootFilterQuery<IProduct>,_skip:number = 0,_limit:number = 15):Promise<IProduct[]>{
        let result = Product.find(body).sort("carbon_emission").skip(_skip).limit(_limit).exec()
        return result
    }

}