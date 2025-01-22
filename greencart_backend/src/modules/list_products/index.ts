import { Types } from "mongoose"


export * from "./listProduct.service"

export interface ListProduct{
        quantity: number
        list:  Types.ObjectId
        product: Types.ObjectId
}