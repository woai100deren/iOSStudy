//
//  购物车
//
//  Created by dodoca on 2020/5/29.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "ShoppingCartViewController.h"
#import "DrinkGoods.h"
#import "ShoppingCartCell.h"
#import "MJExtension.h"

@interface ShoppingCartViewController ()<UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSArray *goodsArray;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;
@end

@implementation ShoppingCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    
    //监听者名称：ShoppingCart，
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dealSubAndAdd:) name:@"shopping" object:nil];
}

//在控制器销毁的时候移除通知
-(void)dealloc{
    //移除通知有两种：1.移除所有通知；2.移除指定通知
    //1.移除所有通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    //2.移除指定通知
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"shopping" object:nil];

}

//加载数据字典数据
- (NSArray *)goodsArray{
    if(!_goodsArray){
        _goodsArray = [DrinkGoods mj_objectArrayWithFilename:@"drinks.plist" ];
    }
    return _goodsArray;
}

-(void)dealSubAndAdd:(NSNotification *)notifycation{
    BOOL flag = [[[notifycation userInfo] valueForKey:@"flag"] boolValue];
    DrinkGoods *drinkGoods = [DrinkGoods mj_objectWithKeyValues:[[notifycation userInfo] valueForKey:@"drinkGoods"]];
    if(flag){//加
       self.totalPriceLabel.text =  [NSString stringWithFormat:@"%d",self.totalPriceLabel.text.intValue +  drinkGoods.price.intValue];
    }else{//减
        self.totalPriceLabel.text =  [NSString stringWithFormat:@"%d",self.totalPriceLabel.text.intValue - drinkGoods.price.intValue];
    }
}

#pragma mark - click
//结算
- (IBAction)settle:(id)sender {
}
//清空购物车
- (IBAction)clearCart:(id)sender {
    self.totalPriceLabel.text = @"0";
    for(DrinkGoods *drinkGoods in self.goodsArray){
        drinkGoods.buyCount = 0;
    }
    [self.tableView reloadData];
}

#pragma mark -tableviewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.goodsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"tag";
    ShoppingCartCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil){
        //通过xib的方式，需要加载xib来处理
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ShoppingCartCell class]) owner:nil options:nil] firstObject];
    }
    cell.drinkGoods = self.goodsArray[indexPath.row];
    return cell;
}

@end
