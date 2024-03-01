import { Injectable, NestMiddleware } from '@nestjs/common';
import * as fs from 'fs';
@Injectable()
export class PolicyMiddleware implements NestMiddleware {
  rules: any;

  constructor() {
    this.rules = JSON.parse(fs.readFileSync('./data.json', 'utf8'));
  }

  use(req: any, res: any, next: () => void) {
    req.rules = this.rules.rules;
    next();
  }
}
