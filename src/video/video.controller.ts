import { Controller, Delete, Get, Param, Query } from '@nestjs/common';
import { VideoService } from './video.service';
import { PaginationDto } from '../author/dto/pagination.dto';

@Controller('video')
export class VideoController {
  constructor(private readonly videoService: VideoService) {}

  @Get('')
  findAll(@Query() query: PaginationDto) {
    const { page, limit } = query;
    return this.videoService.findAll(page, limit);
  }

  @Get('/detail/:id')
  findOne(@Param('id') id: string) {
    return this.videoService.findOne(id);
  }

  @Delete('/delete/:id')
  remove(@Param('id') id: string) {
    return this.videoService.remove(id);
  }
}
