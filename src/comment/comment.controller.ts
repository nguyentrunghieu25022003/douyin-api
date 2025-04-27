import { Controller, Get, Param, Query } from '@nestjs/common';
import { CommentService } from './comment.service';
import { PaginationDto } from '../author/dto/pagination.dto';
@Controller('comment')
export class CommentController {
  constructor(private readonly commentService: CommentService) {}

  @Get(':videoId')
  findAll(@Param('videoId') videoId: string, @Query() query: PaginationDto) {
    const { page, limit } = query;
    return this.commentService.findAll(videoId, page, limit);
  }
}
