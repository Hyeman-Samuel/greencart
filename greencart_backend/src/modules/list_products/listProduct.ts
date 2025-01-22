
import { Schema, Types, model } from 'mongoose';
import { IProduct } from '../products/product';
import { IList } from '../lists/list';

export interface IListProduct {
    _id: Types.ObjectId
    quantity: number
    list: Types.ObjectId | IList
    product: Types.ObjectId | IProduct
}

const listProductSchema = new Schema<IListProduct>({
    quantity: { type: Number, required: true },
    list: { type: Schema.ObjectId, ref:"List", required: true },
    product: { type: Schema.ObjectId, ref:"Product", required: true },
});

export const ListProduct = model<IListProduct>('ListProduct', listProductSchema);
