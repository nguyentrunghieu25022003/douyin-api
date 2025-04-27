import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class UploadService {
  constructor(private readonly prisma: PrismaService) {}

  async handleFile(file: Express.Multer.File, userEmail: string) {
    const fileUrl = `${process.env.PATH}/uploads/${file.filename}`;

    await this.prisma.author.update({
      where: { email: userEmail },
      data: {
        profilePic: [fileUrl],
      },
    });

    return {
      message: 'File uploaded and user updated',
      fileUrl,
    };
  }
}
