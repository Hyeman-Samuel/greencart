
import { Schema, Types, model } from 'mongoose';

export interface IUser {
    _id: Types.ObjectId
    fullName: string
    email: string;
    // isEmailVerified: boolean;
    password: string;
    metadata: object;
}

const userSchema = new Schema<IUser>({
    fullName: { type: String, required: true },
    email: { type: String, required: true },
    //isEmailVerified: { type: Boolean, default: false },
    password: { type: String },
    metadata: { type: Object, required: true, default: {} },
}, {
    toJSON: {
        transform: function (doc, ret) {
            delete ret.password
            return ret
        }
    }
});

export const User = model<IUser>('User', userSchema);
