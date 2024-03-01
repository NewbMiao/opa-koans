import { Injectable } from '@nestjs/common';

@Injectable()
export class AppService {
  rules: any;
  constructor() {}
  composeEntitlements(rules) {
    const productData = {
      version: '1',
      sub_version: '3',
      money_available: 100,
    };
    const fullVersion = `${productData.version}.${productData.sub_version}`;
    return {
      platforms: {
        platforms: this.composePlatforms(fullVersion, rules.platforms),
      },
      orderManagement: {
        enabled: this.composeOrderManagement(
          fullVersion,
          rules.orderManagement,
        ),
      },
      purchaseManagement: {
        enabled: this.composePurchaseManagement(
          productData.money_available,
          rules.purchaseManagement,
        ),
      },
    };
  }

  private composePlatforms(
    fullVersion: string,
    rules: Record<string, any>,
  ): string[] {
    let platforms = [];
    if (rules.oldPlatform.product.fullVersion.includes(fullVersion)) {
      platforms.push('oldPlatform');
    }
    if (rules.newPlatform.product.fullVersion.includes(fullVersion)) {
      platforms.push('newPlatform');
    }
    return platforms;
  }
  composePurchaseManagement(money_available: number, rules: any) {
    return rules.product.money_available.min < money_available;
  }
  private composeOrderManagement(
    fullVersion: string,
    rules: Record<string, any>,
  ) {
    return rules.product.fullVersion.includes(fullVersion);
  }
}
