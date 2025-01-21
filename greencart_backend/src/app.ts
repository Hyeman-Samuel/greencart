import 'reflect-metadata';
import http, { Server } from 'http';
import { Application as ExpressApplication } from 'express';
import { createExpressServer, RoutingControllersOptions, useContainer } from 'routing-controllers';
import path from 'path';
import { Container } from "typedi"



import { configureSwagger } from "./infra/swagger"
import { environment } from './infra/environment';
import { connectDb } from './infra/mongoose';
// import { GlobalErrorHandler } from './ports/middleware/error.middleware';


export class App {
	readonly app: ExpressApplication;
	readonly server: Server;

	constructor() {
		const options: RoutingControllersOptions = {
			routePrefix: '/v1',
			cors: true,
			controllers: [
				path.join(__dirname, '/ports/controllers/*.{ts,js}'),
				path.join(__dirname, '/ports/controllers/*/**/***.{ts,js}'),
			],
			defaultErrorHandler: true,
			// middlewares: [GlobalErrorHandler],
		};

		connectDb().then(() => console.log("Mongoose service started"));

		this.app = createExpressServer(options)
		this.configureServices(this.app)
		if (environment.isDevelopment() || environment.isStaging()) {
			configureSwagger(this.app, options)
		}
		this.server = http.createServer(this.app);
		this.server.listen(environment.port, () =>
			console.log(
				`Server is listening on port ${environment.port}`
			)
		);
	}

	configureServices(app: ExpressApplication) {
		useContainer(Container)
	}
}