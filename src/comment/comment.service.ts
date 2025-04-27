import { Injectable } from '@nestjs/common';
import { Comment } from '@prisma/client';
import { PrismaService } from '../prisma/prisma.service';
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
}
