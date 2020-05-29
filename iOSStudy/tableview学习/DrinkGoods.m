//
//
//  饮料数据模型
//
//  Created by dodoca on 2020/5/29.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "DrinkGoods.h"

@implementation DrinkGoods
- (NSString *)priceShow{
    NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
    NSString *str = [nf stringFromNumber:_price];
    if (str != nil) {
        str = [NSString stringWithFormat:@"%@", _price];
    }
    return str;
}
@end
