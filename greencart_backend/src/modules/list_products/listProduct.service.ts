import { Inject, Service } from "typedi";

import { ListProductStore } from "./listProduct.store";
import { IListProduct } from './listProduct';
import { ListProduct } from ".";



@Service("listProduct.service")
export class ListProductService {
    constructor(
        @Inject("listProduct.store") private readonly listProductStore: ListProductStore,
    ) { }

    async addListProduct(partial: ListProduct): Promise<IListProduct> {
        let listProduct  = await this.listProductStore.get({product:partial.product,list:partial.list})
        if (listProduct){
            listProduct.quantity += partial.quantity??0
            await this.listProductStore.update(listProduct._id.toString(),listProduct)
        }else{
            listProduct = await this.listProductStore.create(partial)
        }
        return listProduct
    }

    async removeListProduct(partial: ListProduct): Promise<boolean> {
        let listProduct  = await this.listProductStore.get({product:partial.product,list:partial.list})

        if(!listProduct)return true
        const remaining = listProduct.quantity - (partial.quantity??1)
        if (remaining > 0){
            listProduct.quantity -= partial.quantity ??0
            await this.listProductStore.update(listProduct._id.toString(),listProduct)
        }else{
            await this.listProductStore.delete(listProduct._id.toString())
        }
        return true
    }


    async findListProduct(filter: Partial<IListProduct>): Promise<IListProduct[]> {
        const listProduct = await this.listProductStore.getAll(filter)
        return listProduct
    }

}