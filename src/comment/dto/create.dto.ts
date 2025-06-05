import { IsString, IsNotEmpty, IsUUID } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class CreateCommentDto {
  @ApiProperty({ example: '8c63b122-04f7-45a3-95c3-725a16eab7cd' })
  @IsUUID()
  @IsNotEmpty()
  videoId: string;

  @ApiProperty({ example: 'b9a5a52e-e9f5-49b3-b7cd-098e3224e320' })
  @IsUUID()
  @IsNotEmpty()
  authorId: string;

  @ApiProperty({ example: 'This video is amazing!' })
  @IsString()
  @IsNotEmpty()
  content: string;
}
