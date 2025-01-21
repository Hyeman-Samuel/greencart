import {
    ExpressMiddlewareInterface
} from 'routing-controllers';
import { Inject, Service } from 'typedi';
import { Response } from 'express';

import { UserService } from '../../modules/users';
import { CustomRequest } from './middleware.interface';


@Service()
export class AuthMiddleware implements ExpressMiddlewareInterface {
    constructor(@Inject("user.service") private readonly userService: UserService){}

    async use(request: CustomRequest, response: Response, next: (err?: any) => any) {
        let authHeader = request.headers.authorization;
        if(!authHeader) 
            return response.status(401).json({message: "invalid authentication token"})

        if(authHeader.split(" ").length !== 2) 
            return response.status(401).json({message: "invalid authentication token"})

        let [bearer, token] = authHeader.split(" ")

        try{
            let userPayload = this.userService.verifyUserToken(token);
            let user = await this.userService.getUserById(userPayload._id);
            if(!user) return response.status(401).json({message: "invalid authentication token"})
            request.user = user;
            request.authenticated = true;
            next();
        }

        catch(e){
            return response.status(401).json({message: "invalid authentication token"})
        }
    }
}
