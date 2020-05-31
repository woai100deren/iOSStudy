//
//  饮料数据模型
//
//  Created by dodoca on 2020/5/29.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface DrinkGoods : NSObject

@property(nonatomic,copy)NSString *icon;
@property(nonatomic,copy)NSNumber *price;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *priceShow;

//购买数量
@property(nonatomic,assign)int buyCount;
@end
