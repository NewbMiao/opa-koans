import { MiddlewareConsumer, Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { PolicyMiddleware } from './policy.middleware';

@Module({
  imports: [],
  controllers: [AppController],
  providers: [],
})
export class AppModule {
  configure(consumer: MiddlewareConsumer) {
    consumer.apply(PolicyMiddleware).forRoutes('/entitlements');
  }
}
