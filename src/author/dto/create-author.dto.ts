import { IsEmail, IsOptional, IsString, MinLength } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class CreateAuthorDto {
  @ApiProperty()
  @IsString()
  username: string;

  @ApiProperty()
  @IsEmail()
  email: string;

  @ApiProperty()
  @MinLength(6)
  @IsString()
  password: string;

  @ApiProperty({ required: false })
  @IsOptional()
  @IsString({ each: true })
  profilePic?: string[];

  @ApiProperty({ required: false })
  @IsOptional()
  @IsString()
  bio?: string;
}
