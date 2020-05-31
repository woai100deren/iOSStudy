//
//  购物车tableviewcell
//
//  Created by dodoca on 2020/5/29.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "ShoppingCartCell.h"
#import "DrinkGoods.h"
#import "MJExtension.h"

@interface ShoppingCartCell ()

@property (weak, nonatomic) IBOutlet UIImageView *goodsIcon;
@property (weak, nonatomic) IBOutlet UILabel *goodsName;
@property (weak, nonatomic) IBOutlet UILabel *goodsPrice;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UIButton *subBottun;

@end

@implementation ShoppingCartCell
- (void)awakeFromNib{
    [super awakeFromNib];
    //添加边框
    self.goodsIcon.layer.borderWidth = 0.5f;
    self.goodsIcon.layer.borderColor = [UIColor orangeColor].CGColor;
}

- (void)setDrinkGoods:(DrinkGoods *)drinkGoods{
    _drinkGoods = drinkGoods;
    if(drinkGoods != nil){
        self.goodsIcon.image = [UIImage imageNamed:drinkGoods.icon];
        self.goodsName.text = drinkGoods.name;
        self.goodsPrice.text = [NSString stringWithFormat:@"单价：%@分",drinkGoods.priceShow];
        self.numLabel.text = [NSString stringWithFormat:@"%d",drinkGoods.buyCount];
        if(drinkGoods.buyCount>0){
            self.subBottun.enabled = YES;
        }else{
            self.subBottun.enabled = NO;
        }
    }
}

#pragma mark - 加、减按钮事件
- (IBAction)sub:(id)sender {
    self.drinkGoods.buyCount --;
    if(self.drinkGoods.buyCount < 1){
        self.subBottun.enabled = NO;
    }
    self.numLabel.text = [NSString stringWithFormat:@"%d",self.drinkGoods.buyCount];
//    [self sendNotify:NO];
}
- (IBAction)add:(id)sender {
    self.drinkGoods.buyCount ++;
    self.numLabel.text = [NSString stringWithFormat:@"%d",self.drinkGoods.buyCount];
    
    if(self.drinkGoods.buyCount > 0){
        self.subBottun.enabled = YES;
    }
    
//    [self sendNotify:YES];
}

/**
 给列表controller发布通知，改变总价格
 */
-(void)sendNotify:(BOOL)isAdd{
    //发送一个通知，通知名称为：shopping，通知发布者：ShoppingCartCell，通知的数据：userInfo
//    NSNotification *notifycation = [NSNotification notificationWithName:@"shopping" object:self userInfo:nil];
//    [[NSNotificationCenter defaultCenter] postNotification:notifycation];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"shopping" object:self userInfo:@{@"flag":[NSNumber numberWithBool:isAdd],@"drinkGoods":self.drinkGoods.mj_keyValues}];
}
@end
