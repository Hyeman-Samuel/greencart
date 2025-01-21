import { Request } from 'express';
import { IUser } from '../../modules/users/user';

export interface CustomRequest extends Request {
	user?: IUser;
	authenticated: boolean;
	featureName?: string;
}