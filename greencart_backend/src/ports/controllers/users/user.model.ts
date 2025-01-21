import { IsEmail, IsString, Length } from "class-validator";

export class UserModel{
    @IsString()
    fullName!: string;

    @IsEmail()
    email!: string;

    @IsString()
    @Length(5)
    password!: string;
}

export class LoginDto {
    @IsEmail()
    email!: string;

    @IsString()
    password!: string;
}

export class VerifyEmailDto {
    @IsEmail()
    email!: string;

    @IsString()
    otp!: string;
}