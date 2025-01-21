import { BadRequestError, Body, Get, JsonController, Post, Req, Res, UseBefore } from "routing-controllers";
import { Inject, Service } from "typedi";
import { Response } from 'express'
import { OpenAPI } from "routing-controllers-openapi";

import { ListService } from "../../../modules/lists";
import { AuthMiddleware } from "../../middlewares/auth.middleware";
import { ListModel } from "./list.model";


@JsonController('/lists')
@Service()
export class ListController {

    constructor(
        @Inject("list.service") private readonly listService: ListService,
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

}