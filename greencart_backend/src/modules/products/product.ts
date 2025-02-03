
import { Schema, Types, model } from 'mongoose';
export enum Category{
    Foodstuff="foodstuff",
    Electronics="electronics",
    Household="household",
    PersonalCare="personal-care",
}

export enum Metric{
    Kilograms="Kilograms",
    Centiliters="Centiliters",
    Mililiters="Mililiters",
    Grams="Grams",
}

export enum Rating{
    High="High",
    Medium="Medium",
    Low="Low"
}

export interface IProduct {
    _id: Types.ObjectId
    title: string
    type: string;
    thumbnail: string;
    carbon_emission: number
    category:Category
    price: number;

    metric:Metric
    quantity:number
    rating:Rating
}

const productSchema = new Schema<IProduct>({
    title: { type: String, required: true },
    type: { type: String, required: true },
    category: { type: String, required: true,enum:Category },
    carbon_emission: { type: Number, required: true },
    thumbnail: { type: String, required: true },
    price: { type: Number, required: true },
    metric: { type: String,enum:Metric },
    rating: { type: String,enum:Rating, required: true  },
    quantity: { type: Number},
});



export const Product = model<IProduct>('Product', productSchema);
