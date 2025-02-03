import { Get, JsonController, Res } from "routing-controllers";
import { Service } from "typedi";
import { Response } from 'express'
import { capitalize } from "lodash"

import { Category } from '../../../modules/products/product';




@JsonController('/categories')
@Service()
export class CategoryController {

    constructor(
    ) { }


    @Get('/')
    async get(@Res() res: Response){
        let categories = Object.values(Category) 
        return res.json({ categories:categories.map(x=> capitalize(x.replace("-"," ")))});
    }

}