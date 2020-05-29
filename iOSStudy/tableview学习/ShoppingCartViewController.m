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
@end

@implementation ShoppingCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
}

//加载数据字典数据
- (NSArray *)goodsArray{
    if(!_goodsArray){
        _goodsArray = [DrinkGoods mj_objectArrayWithFilename:@"drinks.plist" ];
    }
    return _goodsArray;
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
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ShoppingCartCell class]) owner:nil options:nil] lastObject];
    }
    cell.drinkGoods = self.goodsArray[indexPath.row];
    return cell;
}

@end
