export interface JwtPayload {
  id: string;
  email: string;
  role: 'admin' | 'user';
  iat?: number;
  exp?: number;
}
