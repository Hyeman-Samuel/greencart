import { Get, JsonController, Post, QueryParam, Res } from "routing-controllers";
import { Inject, Service } from "typedi";
import { Response } from 'express'

import { ProductService } from "../../../modules/products";
import { Category, Metric } from '../../../modules/products/product';
import { SeededProducts } from '../../../modules/products/seeded_products';


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
            metric:x.MERIC !== ""? x.MERIC as Metric : undefined
        }))
        return res.status(201).json({ products })
    }

    @Get('/')
    async get(@Res() res: Response,@QueryParam("category") category: string,@QueryParam("offset") offset: number = 0,@QueryParam("limit") limit: number = 15){
        let product = await this.productService.findProduct({ category: category as Category })
        return res.json({ product });
    }

}