import { Module } from '@nestjs/common';
import { RepliesService } from './reply.service';
import { RepliesController } from './reply.controller';

@Module({
  providers: [RepliesService],
  controllers: [RepliesController],
})
export class RepliesModule {}
