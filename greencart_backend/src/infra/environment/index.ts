import * as dotenv from 'dotenv';
import { IEnvironment } from './IEnvironment';

dotenv.config();

const {
	PORT,
	ENVIRONMENT,
    MONGO_URL,
    JWT_SECRET,
    JWT_ACCESS_TOKEN_TTL
} = process.env;


export const environment:IEnvironment={
    port: PORT as any,
    isProduction: function (): boolean {
        return ENVIRONMENT == "production";
    },
    isStaging: function (): boolean {
        return ENVIRONMENT == "staging";
    },
    isDevelopment: function (): boolean {
        return ENVIRONMENT == "development";
    },
    mongo: {
        url: MONGO_URL as string
    },
    jwt: {
        secret: JWT_SECRET as string,
        access_token: {
            ttl: JWT_ACCESS_TOKEN_TTL as any
        }
    }
}