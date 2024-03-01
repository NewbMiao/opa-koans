import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';

process.on('SIGINT', function () {
  console.log('Received SIGINT. Exiting...');
  process.exit(0);
});
async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  await app.listen(3001);
}
bootstrap();
