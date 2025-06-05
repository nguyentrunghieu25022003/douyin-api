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
      include: {
        hashtags: {
          include: {
            hashtag: true,
          },
        },
        music: true,
        author: {
          select: {
            username: true,
            profilePic: true,
          },
        },
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

  async like(
    userId: string,
    videoId: string,
  ): Promise<{ liked: boolean; count: number }> {
    const author = await this.prisma.author.findUnique({
      where: {
        id: userId,
      },
    });
    if (!author) {
      throw ErrorMessages.NOT_FOUND;
    }

    const video = await this.findOne(videoId);
    if (!video) {
      throw ErrorMessages.NOT_FOUND;
    }

    const existing = await this.prisma.videoLike.findUnique({
      where: {
        userId_videoId: { userId, videoId },
      },
    });

    if (existing) {
      await this.prisma.videoLike.delete({
        where: { userId_videoId: { userId, videoId } },
      });
    } else {
      await this.prisma.videoLike.create({
        data: {
          userId,
          videoId,
        },
      });
    }

    const count = await this.prisma.videoLike.count({
      where: { videoId },
    });

    return {
      liked: !existing,
      count,
    };
  }
}
