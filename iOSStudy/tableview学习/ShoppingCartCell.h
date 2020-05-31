//
//  购物车tableviewcell
//
//  Created by dodoca on 2020/5/29.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DrinkGoods;

@protocol ShoppingCartCellDelegate <NSObject>

-(void)buyCountNumChanged:(BOOL)isAdd value:(DrinkGoods *)drinkGoods;

@end

@interface ShoppingCartCell : UITableViewCell

@property(nonatomic,copy)DrinkGoods *drinkGoods;

@property(nonatomic,weak) id<ShoppingCartCellDelegate> delegate;

@end
