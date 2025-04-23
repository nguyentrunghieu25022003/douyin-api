import { Injectable } from '@nestjs/common';

@Injectable()
export class UploadService {
  handleFile(file: Express.Multer.File) {
    return {
      message: 'File uploaded',
      filename: file.filename,
      mimetype: file.mimetype,
      size: file.size,
    };
  }
}
