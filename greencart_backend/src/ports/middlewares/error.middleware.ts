import { HttpStatusCode } from 'axios';
import { ValidationError } from 'class-validator';
import { Response } from 'express';

import {
	Middleware,
	ExpressErrorMiddlewareInterface,
	UnauthorizedError,
	HttpError,
	BadRequestError,
} from 'routing-controllers';
import { Service } from 'typedi';


@Service()
@Middleware({ type: 'after' })
export class GlobalErrorHandler implements ExpressErrorMiddlewareInterface {
	error(error: any, request: any, response: any, next: (err: any) => any) {
		const expressResponse = response as Response;

		if (error instanceof UnauthorizedError) {
			return expressResponse
				.status(HttpStatusCode.Unauthorized)
				.json({ errorMesssage: error.message });
		}

		if (
			error instanceof BadRequestError ||
			error.httpCode === HttpStatusCode.BadRequest
		) {
			const { errors } = error;
			const validationChildrenErrors = (errors as ValidationError[])
				.map(c => c?.children!)
				.flatMap(c => c)
				.map(c => Object.values(c?.constraints!))
				.flatMap(c => c);
			const validationErrors = (errors as ValidationError[])
				.map(c => Object.values(c?.constraints!))
				.flatMap(c => c);
			validationErrors.push(...validationChildrenErrors);
			return expressResponse
				.status(HttpStatusCode.BadRequest)
				.json({ validationErrors });
		}

		if (
			error instanceof HttpError &&
			[HttpStatusCode.NotFound, HttpStatusCode.Conflict].includes(error.httpCode)
		) {
			return expressResponse
				.status(error.httpCode)
				.json({ errorMesssage: error.message });
		}
		

		if (error instanceof Error) {
			console.error(error);
			return expressResponse
				.status(HttpStatusCode.InternalServerError)
				.json({ errorMesssage: 'Internal Error Occured' });
		}
	}
}
