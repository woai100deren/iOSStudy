//
//  购物车tableviewcell
//
//  Created by dodoca on 2020/5/29.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "ShoppingCartCell.h"
#import "DrinkGoods.h"

@interface ShoppingCartCell ()

@property (weak, nonatomic) IBOutlet UIImageView *goodsIcon;
@property (weak, nonatomic) IBOutlet UILabel *goodsName;
@property (weak, nonatomic) IBOutlet UILabel *goodsPrice;

@end

@implementation ShoppingCartCell
- (void)awakeFromNib{
    [super awakeFromNib];
    //添加边框
    self.goodsIcon.layer.borderWidth = 0.5f;
    self.goodsIcon.layer.borderColor = [UIColor orangeColor].CGColor;
    
    NSLog(@"11111");
}

- (void)setDrinkGoods:(DrinkGoods *)drinkGoods{
    _drinkGoods = drinkGoods;
    if(drinkGoods != nil){
        self.goodsIcon.image = [UIImage imageNamed:drinkGoods.icon];
        self.goodsName.text = drinkGoods.name;
        self.goodsPrice.text = [NSString stringWithFormat:@"单价：%@分",drinkGoods.priceShow];
    }
}
@end
