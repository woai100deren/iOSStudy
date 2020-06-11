//
//  GestureLockView.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/11.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "GestureLockView.h"
#import "UIView+Extensions.h"

@interface GestureLockView()
/**存放当前选中的按钮*/
@property(nonatomic,strong,nonnull)NSMutableArray *selectedBtnArray;
@property(assign,nonatomic)CGPoint currentPoint;
@end

@implementation GestureLockView

- (NSMutableArray *)selectedBtnArray{
    if(_selectedBtnArray == nil){
        _selectedBtnArray = [NSMutableArray array];
    }
    return _selectedBtnArray;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setUpView];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    //定义间距都是10
    CGFloat space = 10;
    //计算每个按钮的高宽
    CGFloat btnWith = (self.bounds.size.width - space * 4)/3;
    //行
    int currentRow = 0;
    //列
    int currentLine = 0;
    
    //取出每一个按钮设置frame
    for(int i=0;i<self.subviews.count;i++){
        UIButton *btn = self.subviews[i];
        btn.userInteractionEnabled = NO;
        currentRow = i / 3;
        currentLine = i % 3;
        btn.tag = i;
        
       btn.frame = CGRectMake(currentLine*btnWith + (currentLine + 1)*space, currentRow*btnWith + (currentRow + 1)*space, btnWith, btnWith);
    }
}

-(void)setUpView{
    for(int i=0;i<9;i++){
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        //设置按钮图片
        [button setImage:[UIImage imageNamed:@"gesture_btn_normal"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"gesture_btn_selected"] forState:UIControlStateSelected];
        [button setImage:[UIImage imageNamed:@"gesture_btn_selected"] forState:UIControlStateHighlighted];
        
        [self addSubview:button];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UIButton *btn = [self getCurrentPointButton:[self getCurrentTouchPoint:touches]];
    if(btn){
        btn.selected = YES;
        if(![self.selectedBtnArray containsObject:btn]){
            [self.selectedBtnArray addObject:btn];
        }
    }
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.currentPoint = [self getCurrentTouchPoint:touches];
    UIButton *btn = [self getCurrentPointButton:self.currentPoint];
    if(btn){
        btn.selected = YES;
        if(![self.selectedBtnArray containsObject:btn]){
            [self.selectedBtnArray addObject:btn];
        }
    }
    [self setNeedsDisplay];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSMutableString *str = [NSMutableString string];
    //取消所有选中的状态
    for(UIButton *btn in self.selectedBtnArray){
        btn.selected = NO;
        [str appendFormat:@"%ld",btn.tag];
    }
    //清空路径
    [self.selectedBtnArray removeAllObjects];
    [self setNeedsDisplay];
    
    
    NSString *gesturePwd = [[NSUserDefaults standardUserDefaults] objectForKey:@"gesturePwd"];
    if(!gesturePwd){
        [[NSUserDefaults standardUserDefaults] setObject:str forKey:@"gesturePwd"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"密码录入成功" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:okAction];
        [[self viewController]  presentViewController:alertController animated:YES completion:nil];
    }else{
        NSString *message;
        if([str isEqual:gesturePwd]){
            message = @"密码验证成功";
        }else{
            message = @"密码验证失败";
        }
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:okAction];
        [[self viewController]  presentViewController:alertController animated:YES completion:nil];
    }
}
- (void)drawRect:(CGRect)rect{
    if(self.selectedBtnArray.count == 0){
        return;
    }
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    for(int i=0;i<self.selectedBtnArray.count;i++){
        UIButton *btn = self.selectedBtnArray[i];
        if(i == 0){
            [path moveToPoint:btn.center];
        }else{
            [path addLineToPoint:btn.center];
        }
    }
    
    [[UIColor redColor] set];
    //设置线的宽度
    [path setLineWidth:10];
    //线的顶角样式
    [path setLineJoinStyle:kCGLineJoinRound];
    
    //添加一根线到手指所在的点
    [path addLineToPoint:self.currentPoint];
    [path stroke];
}
/**
 获取当前手指在屏幕的点
 */
-(CGPoint)getCurrentTouchPoint:(NSSet<UITouch *> *)touches{
    UITouch *touch = [touches anyObject];
    return [touch locationInView:self];
}
/**
 获取当前手指所在的按钮
 */
-(UIButton *)getCurrentPointButton:(CGPoint)point{
    //当前手指所在点是不是在按钮上
    for(UIButton *btn in self.subviews){
        if(CGRectContainsPoint(btn.frame, point)){
            return btn;
        }
    }
    return nil;
}

- (void)clearPwd{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"gesturePwd"];
}
@end
