export type IEnvironment = {
	port: number
	isProduction: () => boolean;
	isStaging: () => boolean;
	isDevelopment: () => boolean;
	jwt: {
		secret: string
		access_token: {
			ttl: number
		}
	},
	mongo: {
		url: string
	}
}