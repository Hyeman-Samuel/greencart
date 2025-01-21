import { Get, JsonController, QueryParam, Res } from "routing-controllers";
import { Inject, Service } from "typedi";
import { Response } from 'express'

import { ProductService } from "../../../modules/products";
import { Category } from '../../../modules/products/product';


@JsonController('/products')
@Service()
export class ProductController {

    constructor(
        @Inject("product.service") private readonly productService: ProductService,
    ) { }


    // @Post('/')
    // @OpenAPI({ security: [{ bearerAuth: [] }] })
    // @UseBefore(AuthMiddleware)
    // async create(@Body() input: ProductModel, @Res() res: Response,@Req() req: any, ){
    //     if(await this.productService.findUnique({ title: input.title }))
    //         throw new BadRequestError("product title already taken")

    //     let product = await this.productService.createProduct({ ...input,user_id:req.user._id });
    //     return res.status(201).json({ product })
    // }

    @Get('/')
    async get(@Res() res: Response,@QueryParam("category") category: string,@QueryParam("offset") offset: number = 0,@QueryParam("limit") limit: number = 15){
        let product = await this.productService.findProduct({ category: category as Category })
        return res.json({ product });
    }

}