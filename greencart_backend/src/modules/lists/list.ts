
import { Schema, Types, model } from 'mongoose';

export interface IList {
    _id: Types.ObjectId
    title: string
    description: string;
}

const listSchema = new Schema<IList>({
    title: { type: String, required: true },
    description: { type: String, required: true },
});

export const List = model<IList>('List', listSchema);
