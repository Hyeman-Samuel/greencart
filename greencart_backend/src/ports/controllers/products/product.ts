import { Get, JsonController, NotFoundError, Param, Post, QueryParam, Res } from "routing-controllers";
import { Inject, Service } from "typedi";
import { Response } from 'express'
import { Types } from "mongoose";

import { ProductService } from "../../../modules/products";
import { Category, Metric, Rating } from '../../../modules/products/product';
import { SeededProducts } from '../../../modules/products/seeded_products';
import slugify from "slugify/slugify";


@JsonController('/products')
@Service()
export class ProductController {

    constructor(
        @Inject("product.service") private readonly productService: ProductService,
    ) { }


    @Post('/')
    async load(@Res() res: Response ){
        let products = SeededProducts.map(async x=> await this.productService.createProduct({
            title:x.NAME,
            type:x.TYPE,
            carbon_emission:x.CARBON_EMISSIONS,
            price:x.MARKET_PRICE,
            category:x.CATEGORIES as Category,
            quantity:x.QUANTITY !== ""? parseFloat(x.QUANTITY.toString()) : undefined,
            metric:x.METRIC
            !== ""? x.METRIC as Metric : undefined,
            rating:x.IMPACT_LEVEL_RATING as Rating,
            thumbnail:x.THUMBNAIL
        }))
        return res.status(201).json({ products })
    }

    @Get('/')
    async get(@Res() res: Response,@QueryParam("category") category: string,@QueryParam("offset") offset: number = 0,@QueryParam("limit") limit: number = 15){
        let product = await this.productService.findProduct({ category: slugify(category).toLowerCase() as Category })
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