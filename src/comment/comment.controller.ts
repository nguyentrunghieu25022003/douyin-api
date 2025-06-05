import { Body, Controller, Get, Param, Post, Query } from '@nestjs/common';
import { CommentService } from './comment.service';
import { PaginationDto } from '../author/dto/pagination.dto';
import { CreateCommentDto } from './dto/create.dto';
@Controller('comment')
export class CommentController {
  constructor(private readonly commentService: CommentService) {}

  @Get(':videoId')
  findAll(@Param('videoId') videoId: string, @Query() query: PaginationDto) {
    const { page, limit } = query;
    return this.commentService.findAll(videoId, page, limit);
  }

  @Post('create')
  create(@Body() commentDto: CreateCommentDto) {
    const { authorId, videoId, content } = commentDto;
    return this.commentService.create(videoId, authorId, content);
  }
}
