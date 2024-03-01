import { Controller, Get, Req } from '@nestjs/common';
import { AppService } from './app.service';

@Controller('/entitlements')
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Get()
  getEntitlements(@Req() req: any): object {
    return this.appService.composeEntitlements(req.rules);
  }
}
