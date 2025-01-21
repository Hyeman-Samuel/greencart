import { Inject, Service } from "typedi";
import { BadRequestError, NotFoundError } from "routing-controllers";

import { ProductStore } from "./product.store";
import { IProduct } from './product';



@Service("product.service")
export class ProductService {
    constructor(
        @Inject("product.store") private readonly productStore: ProductStore,
    ) { }

    async findUniqueOrFail(filter: Partial<IProduct>): Promise<IProduct> {
        const product = await this.productStore.get(filter)
        if (!product) throw new NotFoundError("Product Not Found")
        return product
    }


    async findUnique(filter: Partial<IProduct>): Promise<IProduct | null> {
        const product = await this.productStore.get(filter)
        return product
    }

    async getProductById(id: string){
        return this.productStore.findById(id)
    }

    async createProduct(partial: Partial<IProduct>): Promise<IProduct> {
        const product = await this.productStore.create(partial)
        if (!product) throw new BadRequestError("Product creation failed");

        return product
    }

    async updateProduct(id: string, partial: Partial<IProduct>): Promise<IProduct> {
        const product = await this.productStore.update(id, partial)
        if (!product) throw new BadRequestError("Product update failed")
        return product
    }

    async findProduct(filter: Partial<IProduct>): Promise<IProduct[]> {
        const product = await this.productStore.getAll(filter)
        return product
    }

}