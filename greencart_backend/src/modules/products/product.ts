
import { Schema, Types, model } from 'mongoose';
export enum Category{
    Foodstuff="foodstuff",
    Electronics="electronics",
    Household="household",
    PersonalCare="personal-care",
}

export enum Metric{
    Kilograms="kilograms",
    Centiliters="centiliters",
    Mililiters="mililiters",
    Grams="grams",
}
export interface IProduct {
    _id: Types.ObjectId
    title: string
    type: string;
    carbon_emission: number
    category:Category
    price: number;

    metric:Metric
    quantity:number
}

const productSchema = new Schema<IProduct>({
    title: { type: String, required: true },
    type: { type: String, required: true },
    category: { type: String, required: true,enum:Category },
    carbon_emission: { type: Number, required: true },
    price: { type: Number, required: true },
    metric: { type: String,enum:Metric },
    quantity: { type: Number},
});



export const Product = model<IProduct>('Product', productSchema);
