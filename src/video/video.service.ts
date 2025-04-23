import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { Video } from '@prisma/client';
import { ErrorMessages } from '../common/errors/error-message';

@Injectable()
export class VideoService {
  constructor(private readonly prisma: PrismaService) {}

  findAll(page = 1, limit = 10): Promise<Video[]> {
    const skip = (page - 1) * limit;

    return this.prisma.video.findMany({
      skip,
      take: limit,
      orderBy: {
        createdAt: 'desc',
      },
    });
  }

  async findOne(id: string): Promise<Video> {
    const video = await this.prisma.video.findUnique({ where: { id } });
    if (!video) {
      throw ErrorMessages.NOT_FOUND;
    }
    return video;
  }
}
