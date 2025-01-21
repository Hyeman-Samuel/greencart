import { BadRequestError, Body, Get, JsonController, Post, QueryParam, Req, Res, UseBefore } from "routing-controllers";
import { Service } from "typedi";
import { Response } from 'express'
import { Category } from '../../../modules/products/product';




@JsonController('/categories')
@Service()
export class CategoryController {

    constructor(
    ) { }


    @Get('/')
    async get(@Res() res: Response){
        let categories = Object.keys(Category) 
        return res.json({ categories });
    }

}