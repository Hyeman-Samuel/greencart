import { IsOptional, IsString } from "class-validator";

export class ListModel{
    @IsString()
    title!: string;

    @IsOptional()
    @IsString()
    description?: string;
}
