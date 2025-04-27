import {
  WebSocketGateway,
  WebSocketServer,
  SubscribeMessage,
  MessageBody,
} from '@nestjs/websockets';
import { Server } from 'socket.io';

@WebSocketGateway({ cors: true })
export class VideoGateway {
  @WebSocketServer()
  server: Server;
  emitLike(videoId: string, count: number) {
    this.server.emit('videoLiked', { videoId, count });
  }

  @SubscribeMessage('likeVideo')
  handleLike(@MessageBody() data: { videoId: string }) {
    console.log(`Video ${data.videoId} liked`);
    this.server.emit('videoLiked', {
      videoId: data.videoId,
      count: Math.floor(Math.random() * 1000),
    });
  }
}
