import { Injectable, NestMiddleware } from '@nestjs/common';
import { loadPolicy } from '@open-policy-agent/opa-wasm';
import * as fs from 'fs';
@Injectable()
export class PolicyMiddleware implements NestMiddleware {
  private poliyFn: any;

  constructor() {
    (async () => {
      const policyWasm = fs.readFileSync('./policy.wasm');
      const rules = JSON.parse(fs.readFileSync('./data.json', 'utf8'));
      const policy = await loadPolicy(policyWasm).then((policy) => {
        policy.setData(rules);
        return policy;
      });
      this.poliyFn = (input) => policy.evaluate(input, 'entitlements/main');
    })();
  }

  use(req: any, res: any, next: () => void) {
    req.poliyFn = this.poliyFn;
    next();
  }
}
