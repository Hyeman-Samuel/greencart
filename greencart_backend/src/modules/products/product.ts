
import { Schema, Types, model } from 'mongoose';
export enum Category{
    Beverages="Beverages"
}

export interface IProduct {
    _id: Types.ObjectId
    title: string
    type: string;
    carbon_emission: number
    category:Category
    price: number;
}

const productSchema = new Schema<IProduct>({
    title: { type: String, required: true },
    type: { type: String, required: true },
    category: { type: String, required: true,enum:Category },
    carbon_emission: { type: Number, required: true },
    price: { type: Number, required: true },
});



export const Product = model<IProduct>('Product', productSchema);
