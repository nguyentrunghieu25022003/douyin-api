import { Controller, Get, Param, Query } from '@nestjs/common';
import { VideoService } from './video.service';
import { PaginationDto } from '../author/dto/pagination.dto';

@Controller('video')
export class VideoController {
  constructor(private readonly videoService: VideoService) {}

  @Get('/all')
  findAll(@Query() query: PaginationDto) {
    const { page, limit } = query;
    return this.videoService.findAll(page, limit);
  }

  @Get('/:id')
  findOne(@Param('id') id: string) {
    return this.videoService.findOne(id);
  }
}
