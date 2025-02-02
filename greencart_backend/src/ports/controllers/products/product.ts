import { Get, JsonController, NotFoundError, Param, Post, QueryParam, Res } from "routing-controllers";
import { Inject, Service } from "typedi";
import { Response } from 'express'
import { Types } from "mongoose";

import { ProductService } from "../../../modules/products";
import { Category } from '../../../modules/products/product';



@JsonController('/products')
@Service()
export class ProductController {

    constructor(
        @Inject("product.service") private readonly productService: ProductService,
    ) { }


    // @Post('/')
    // async load(@Res() res: Response ){
    //     let products = SeededProducts.map(async x=> await this.productService.createProduct({
    //         title:x.NAME,
    //         type:x.TYPE,
    //         carbon_emission:x.CARBON_EMISSIONS,
    //         price:x.MARKET_PRICE,
    //         category:x.CATEGORIES as Category,
    //         quantity:x.QUANTITY !== ""? parseFloat(x.QUANTITY.toString()) : undefined,
    //         metric:x.MERIC !== ""? x.MERIC as Metric : undefined
    //     }))
    //     return res.status(201).json({ products })
    // }

    @Get('/')
    async get(@Res() res: Response,@QueryParam("category") category: string,@QueryParam("offset") offset: number = 0,@QueryParam("limit") limit: number = 15){
        let product = await this.productService.findProduct({ category: category as Category })
        return res.json({ product });
    }

    @Get('/:id/alternatives')
    async alternatives(@Res() res: Response,@Param("id") id: string,@QueryParam("offset") offset: number = 0,@QueryParam("limit") limit: number = 15){

        let product = await this.productService.findUnique({_id:new Types.ObjectId(id)})
        if (!product) throw new NotFoundError("Product not found")
        let products = await this.productService.findProducts({
            type:product.type,
            carbon_emission:{$lt:product.carbon_emission}
        },offset,limit)
        return res.json({ products:products.map(x=>{
            return {x,carbon_reduction:((x.carbon_emission/product.carbon_emission)*100).toFixed(1)}
        }) });
    }

}