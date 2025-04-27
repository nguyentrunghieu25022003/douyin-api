import {
  Controller,
  Get,
  Post,
  Put,
  Delete,
  Body,
  Param,
  Query,
} from '@nestjs/common';
import { AuthorService } from './author.service';
import {
  CreateAuthorDto,
  UpdateAuthorDto,
  PaginationDto,
} from './dto/index.dto';

@Controller('author')
export class AuthorController {
  constructor(private readonly authorService: AuthorService) {}

  @Get('')
  findAll(@Query() query: PaginationDto) {
    const { page, limit } = query;
    return this.authorService.findAll(page, limit);
  }

  @Get('/detail/:id')
  findOne(@Param('id') id: string) {
    return this.authorService.findOne(id);
  }

  @Post('/create')
  create(@Body() data: CreateAuthorDto) {
    return this.authorService.create(data);
  }

  @Put('/update/:id')
  update(@Param('id') id: string, @Body() data: UpdateAuthorDto) {
    return this.authorService.update(id, data);
  }

  @Delete('/delete/:id')
  remove(@Param('id') id: string) {
    return this.authorService.remove(id);
  }
}
