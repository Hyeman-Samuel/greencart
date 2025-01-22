import { IsNumber, IsOptional, IsString } from "class-validator";

export class ListModel{
    @IsString()
    title!: string;

    @IsOptional()
    @IsString()
    description?: string;
}


export class ListProductModel{

    @IsOptional()
    @IsNumber()
    quantity: number = 1

    @IsString()
    product!: string
}
