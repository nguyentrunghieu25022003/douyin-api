import { PassportStrategy } from '@nestjs/passport';
import { Injectable } from '@nestjs/common';
import { AuthService } from './auth.service';
import { Strategy as LocalStrategyBase } from 'passport-local';
import { JwtPayload } from './interfaces/jwt-payload.interface';
import { ErrorMessages } from '../common/errors/error-message';

@Injectable()
export class LocalStrategy extends PassportStrategy(LocalStrategyBase) {
  constructor(private authService: AuthService) {
    super({ usernameField: 'email' });
  }

  async validate(email: string, password: string): Promise<JwtPayload> {
    const user = await this.authService.validateUser(email, password);
    if (!user) {
      throw ErrorMessages.UNAUTHORIZED;
    }
    const { id } = user as unknown as { id: string };
    return {
      email: user.email,
      id: id,
      role: user.role as 'admin' | 'user',
    };
  }
}
