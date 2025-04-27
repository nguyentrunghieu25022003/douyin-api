import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { Video, Hashtag } from '@prisma/client';
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
      include: {
        hashtags: {
          include: {
            hashtag: true,
          },
        },
        music: true,
      },
    });
  }

  async findOne(id: string): Promise<Video> {
    const video = await this.prisma.video.findUnique({
      where: { id },
      include: {
        hashtags: {
          include: {
            hashtag: true,
          },
        },
        music: true,
      },
    });
    if (!video) {
      throw ErrorMessages.NOT_FOUND;
    }
    return video;
  }

  async remove(id: string): Promise<Video> {
    const video = await this.findOne(id);
    if (!video) {
      throw ErrorMessages.NOT_FOUND;
    }
    return this.prisma.video.delete({ where: { id } });
  }
}
