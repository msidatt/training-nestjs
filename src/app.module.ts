import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { TodoModule } from './todo/todo.module';
import { EnvModule } from './env/env.module';

@Module({
  imports: [TodoModule, EnvModule],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
