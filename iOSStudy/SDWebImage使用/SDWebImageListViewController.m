//
//  SDWebImageViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/16.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "SDWebImageListViewController.h"
#import "SDGameModel.h"
#import "SDGameTableViewCell.h"
#import "MJExtension.h"

@interface SDWebImageListViewController ()<UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSArray *imageModelArray;
@end

@implementation SDWebImageListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"SDWebImage列表加载图片";
    
    [self loadData];
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

-(void)loadData{
    self.imageModelArray = [SDGameModel mj_objectArrayWithFilename:@"games.plist" ];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *ID = @"tag";
    
    SDGameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil){
        //二、通过xib的方式，需要加载xib来处理
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([SDGameTableViewCell class]) owner:self options:nil] lastObject];
    }
    cell.gameModel = self.imageModelArray[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.imageModelArray.count;
}
@end
