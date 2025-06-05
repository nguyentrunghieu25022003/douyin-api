import * as bcrypt from 'bcrypt';
import { Injectable } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { PrismaService } from '../prisma/prisma.service';
import { JwtPayload } from './interfaces/jwt-payload.interface';
import { ErrorMessages } from '../common/errors/error-message';
import { Author } from '@prisma/client';
import { RegisterDto } from './dto/register.dto';

@Injectable()
export class AuthService {
  constructor(
    private prisma: PrismaService,
    private jwtService: JwtService,
  ) {}

  async validateUser(
    email: string,
    password: string,
  ): Promise<Omit<Author, 'password'> | null> {
    const user = await this.prisma.author.findUnique({ where: { email } });
    if (user && (await bcrypt.compare(password, user.password))) {
      const { password, ...result } = user;
      return result;
    }
    return null;
  }

  async register(registerDto: RegisterDto): Promise<any> {
    const { username, email, password } = registerDto;

    const existing = await this.prisma.author.findFirst({
      where: {
        OR: [{ email }, { username }],
      },
    });

    if (existing) {
      throw ErrorMessages.BAD_REQUEST;
    }

    const hashedPassword = await bcrypt.hash(password, 10);

    const user = await this.prisma.author.create({
      data: {
        username,
        email,
        password: hashedPassword,
      },
    });

    return {
      message: 'Register successful',
      user: {
        id: user.id,
        username: user.username,
        email: user.email,
      },
    };
  }

  login(user: JwtPayload) {
    const payload = { email: user.email, sub: user.id, role: user.role };

    return {
      user: {
        id: user.id,
        email: user.email,
        role: user.role,
      },
      access_token: this.jwtService.sign(payload, { expiresIn: '15m' }),
      refresh_token: this.jwtService.sign(payload, { expiresIn: '7d' }),
    };
  }

  refreshToken(refreshToken: string) {
    try {
      const payload = this.jwtService.verify<JwtPayload>(refreshToken);
      const newAccessToken = this.jwtService.sign(
        { email: payload.email, sub: payload.id, role: payload.role },
        { expiresIn: '15m' },
      );
      return { access_token: newAccessToken };
    } catch {
      throw ErrorMessages.INVALID_TOKEN;
    }
  }
}
