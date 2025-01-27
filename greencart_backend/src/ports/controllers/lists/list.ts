import { BadRequestError, Body, Delete, Get, JsonController, Param, Post, QueryParam, Req, Res, UseBefore } from "routing-controllers";
import { Inject, Service } from "typedi";
import { Response } from 'express'
import { OpenAPI } from "routing-controllers-openapi";
import { Types } from "mongoose";

import { ListService } from "../../../modules/lists";
import { AuthMiddleware } from "../../middlewares/auth.middleware";
import { ListModel, ListProductModel } from "./list.model";
import { ListProductService } from "../../../modules/list_products";



@JsonController('/lists')
@Service()
export class ListController {

    constructor(
        @Inject("list.service") private readonly listService: ListService,
        @Inject("listProduct.service") private readonly listProductService: ListProductService,
    ) { }


    @Post('/')
    @OpenAPI({ security: [{ bearerAuth: [] }] })
    @UseBefore(AuthMiddleware)
    async create(@Body() input: ListModel, @Res() res: Response,@Req() req: any, ){
        if(await this.listService.findUnique({ title: input.title }))
            throw new BadRequestError("list title already taken")

        let list = await this.listService.createList({ ...input,user_id:req.user._id });
        return res.status(201).json({ list })
    }


    @Get('/')
    @OpenAPI({ security: [{ bearerAuth: [] }] })
    @UseBefore(AuthMiddleware)
    async get(@Req() req: any, @Res() res: Response){
        let list = await this.listService.findList({ user_id: req.user._id })
        return res.json({ list });
    }


    @Get('/:id')
    @OpenAPI({ security: [{ bearerAuth: [] }] })
    @UseBefore(AuthMiddleware)
    async products(@Param("id") list_id: string,@Req() req: any, @Res() res: Response){
        let list = await this.listProductService.findListProduct({ list:new Types.ObjectId(list_id) })
        return res.json({ list });
    }

    @Post('/:id')
    @OpenAPI({ security: [{ bearerAuth: [] }] })
    @UseBefore(AuthMiddleware)
    async add(@Param("id") list_id: string,@Body() input: ListProductModel,@Req() req: any, @Res() res: Response){
        await this.listProductService.addListProduct({
            list: new Types.ObjectId(list_id) ,
            product: new Types.ObjectId(input.product),
            quantity: input.quantity
        })
        return res.sendStatus(201);
    }

    @Delete('/:id')
    @OpenAPI({ security: [{ bearerAuth: [] }] })
    @UseBefore(AuthMiddleware)
    async remove(@Param("id") list_id: string,@Body() input: ListProductModel,@Req() req: any, @Res() res: Response){
        await this.listProductService.addListProduct({
            list: new Types.ObjectId(list_id) ,
            product: new Types.ObjectId(input.product),
            quantity: input.quantity
        })
        return res.sendStatus(200);
    }

}