import * as bcrypt from 'bcrypt';
import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { Author, Prisma } from '@prisma/client';
import { ErrorMessages } from '../common/errors/error-message';

@Injectable()
export class AuthorService {
  constructor(private readonly prisma: PrismaService) {}
  findAll(page = 1, limit = 10): Promise<Author[]> {
    const skip = (page - 1) * limit;

    return this.prisma.author.findMany({
      skip,
      take: limit,
      orderBy: {
        createdAt: 'desc',
      },
    });
  }

  async findOne(id: string): Promise<Author> {
    const author = await this.prisma.author.findUnique({ where: { id } });
    if (!author) {
      throw ErrorMessages.NOT_FOUND;
    }
    return author;
  }

  async create(
    data: Prisma.AuthorCreateInput,
  ): Promise<Omit<Author, 'password'>> {
    const hashedPassword = await bcrypt.hash(data.password, 10);

    const author = await this.prisma.author.create({
      data: {
        ...data,
        password: hashedPassword,
      },
    });

    const { password, ...authorWithoutPassword } = author;
    return authorWithoutPassword;
  }

  async update(id: string, data: Prisma.AuthorUpdateInput): Promise<Author> {
    const existing = await this.findOne(id);
    if (!existing) {
      throw ErrorMessages.NOT_FOUND;
    }
    return this.prisma.author.update({
      where: { id },
      data,
    });
  }

  async remove(id: string): Promise<Author> {
    const existing = await this.findOne(id);
    if (!existing) {
      throw ErrorMessages.NOT_FOUND;
    }
    return this.prisma.author.delete({ where: { id } });
  }
}
