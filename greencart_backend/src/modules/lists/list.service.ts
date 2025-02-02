import { Inject, Service } from "typedi";
import { BadRequestError, NotFoundError } from "routing-controllers";

import { ListStore } from "./list.store";
import { IList } from './list';



@Service("list.service")
export class ListService {
    constructor(
        @Inject("list.store") private readonly listStore: ListStore,
    ) { }


    async findUniqueOrFail(filter: Partial<IList>): Promise<IList> {
        const list = await this.listStore.get(filter)
        if (!list) throw new NotFoundError("List Not Found")
        return list
    }


    async findUnique(filter: Partial<IList>): Promise<IList | null> {
        const list = await this.listStore.get(filter)
        return list
    }

    async getListById(id: string){
        return this.listStore.findById(id)
    }

    async createList(partial: Partial<IList>): Promise<IList> {
        const list = await this.listStore.create(partial)
        if (!list) throw new BadRequestError("List creation failed");

        return list
    }

    async updateList(id: string, partial: Partial<IList>): Promise<IList> {
        const list = await this.listStore.update(id, partial)
        if (!list) throw new BadRequestError("List update failed")
        return list
    }

    async findList(filter: Partial<IList>): Promise<IList[]> {
        const list = await this.listStore.getAll(filter)
        return list
    }

    async deleteList(id:string): Promise<boolean> {
        const list = await this.listStore.delete(id)
        return list
    }

}