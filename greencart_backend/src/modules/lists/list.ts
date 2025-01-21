
import { Schema, Types, model } from 'mongoose';

export interface IList {
    _id: Types.ObjectId
    title: string
    description: string;
    user_id: Types.ObjectId
}

const listSchema = new Schema<IList>({
    title: { type: String, required: true },
    description: { type: String, required: true },
    user_id: { type: Schema.ObjectId, ref:"User", required: true },
});

export const List = model<IList>('List', listSchema);
