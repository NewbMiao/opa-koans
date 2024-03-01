import { Controller, Get, Req } from '@nestjs/common';

@Controller('/entitlements')
export class AppController {
  @Get()
  async getEntitlements(@Req() req: any): Promise<object> {
    const input = {
      product: {
        version: '1',
        sub_version: '3',
        money_available: 100,
      },
    };
    return req.poliyFn(input);
  }
}
