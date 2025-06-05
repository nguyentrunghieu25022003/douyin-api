import { Injectable } from '@nestjs/common';
import { Comment } from '@prisma/client';
import { PrismaService } from '../prisma/prisma.service';
import { ErrorMessages } from 'src/common/errors/error-message';
@Injectable()
export class CommentService {
  constructor(private readonly prismaService: PrismaService) {}

  findAll(id: string, page = 1, limit = 10): Promise<Comment[]> {
    const skip = (page - 1) * limit;

    return this.prismaService.comment.findMany({
      where: {
        videoId: id,
      },
      skip,
      take: limit,
      orderBy: {
        createdAt: 'desc',
      },
    });
  }

  async create(
    videoId: string,
    authorId: string,
    content: string,
  ): Promise<Comment> {
    const author = await this.prismaService.author.findUnique({
      where: {
        id: authorId,
      },
    });
    const video = await this.prismaService.video.findUnique({
      where: {
        id: videoId,
      },
    });
    console.log('authorId:', authorId);
    console.log('videoId:', videoId);
    if (!author || !video) {
      throw ErrorMessages.NOT_FOUND;
    }
    return this.prismaService.comment.create({
      data: {
        videoId: videoId,
        authorId: authorId,
        content: content,
      },
    });
  }
}
