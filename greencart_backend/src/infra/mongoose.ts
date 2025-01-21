import { connect } from 'mongoose';

import { environment } from './environment';
export async function connectDb(){
    const instance = await connect(environment.mongo.url);
    console.log(`Mongo Connection established on port ${instance.connection.port}`)
}