import {
  WebSocketGateway,
  WebSocketServer,
  SubscribeMessage,
  MessageBody,
} from '@nestjs/websockets';
import { Server, Socket } from 'socket.io';
import { VideoService } from '../video/video.service';

@WebSocketGateway({ cors: true })
export class VideoGateway {
  constructor(private readonly videoService: VideoService) {}

  @WebSocketServer()
  server: Server;
  emitLike(videoId: string, count: number) {
    console.log('Ok');
  }

  @SubscribeMessage('likeVideo')
  handleLike(@MessageBody() data: { userId: string; videoId: string }) {
    console.log(`Video ${data.videoId} liked`);
  }
}
