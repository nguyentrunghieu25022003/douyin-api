import { Module } from '@nestjs/common';
import { PrismaModule } from './prisma/prisma.module';
import { VideoModule } from './video/video.module';
import { CommentModule } from './comment/comment.module';
import { RepliesModule } from './reply/reply.module';
import { AuthorModule } from './author/author.module';
import { AuthModule } from './auth/auth.module';
import { UploadController } from './upload/upload.controller';
import { UploadService } from './upload/upload.service';
import { UploadModule } from './upload/upload.module';
import { VideoGateway } from './gateways/video.gateway';

@Module({
  imports: [
    PrismaModule,
    VideoModule,
    CommentModule,
    RepliesModule,
    AuthorModule,
    AuthModule,
    UploadModule,
  ],
  controllers: [UploadController],
  providers: [UploadService, VideoGateway],
})
export class AppModule {}
