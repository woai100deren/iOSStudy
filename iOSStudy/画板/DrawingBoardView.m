//
//  DrawingBoardView.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/11.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "DrawingBoardView.h"
#import "DBUIBezierPath.h"

@interface DrawingBoardView()
/**当前的路径*/
@property(nonatomic,strong)UIBezierPath *path;
/**保存当前的所有路径*/
@property(nonatomic,strong)NSMutableArray *allPathArray;
@end

@implementation DrawingBoardView

- (NSMutableArray *)allPathArray{
    if(_allPathArray == nil){
        _allPathArray = [NSMutableArray array];
    }
    return _allPathArray;
}

- (UIColor *)penColor{
    if(_penColor == nil){
        _penColor = UIColor.blackColor;
    }
    return _penColor;
}

- (CGFloat)penStroke{
    if(_penStroke <= 1){
        _penStroke = 1;
    }
    return _penStroke;
}

- (void)setImage:(UIImage *)image{
    _image = image;
    [self.allPathArray addObject:image];
    [self setNeedsDisplay];
}

- (void)awakeFromNib{
    [super awakeFromNib];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pan];
}

-(void)pan:(UIPanGestureRecognizer *)panGes{
    CGPoint currentPoint = [panGes locationInView:self];
    if(panGes.state == UIGestureRecognizerStateBegan){
        DBUIBezierPath *path = [DBUIBezierPath bezierPath];
        self.path = path;
        
        path.lineWidth = self.penStroke;
        path.color = self.penColor;
        
        [path moveToPoint:currentPoint];
        [self.allPathArray addObject:path];
    }else if(panGes.state == UIGestureRecognizerStateChanged){
        //绘制一根线到当前手指所在的位置
        [self.path addLineToPoint:currentPoint];
        [self setNeedsDisplay];
    }
}

-(void)drawRect:(CGRect)rect{
    for(DBUIBezierPath *path in self.allPathArray){
        if([path isKindOfClass:[UIImage class]]){
            UIImage *image = (UIImage *)path;
            [image drawInRect:rect];
        }else{
            [path.color set];
            [path stroke];
        }
    }
}
/**
 清屏
 */
- (void)clearAll{
    [self.allPathArray removeAllObjects];
    [self setNeedsDisplay];
}
/**
撤销一步
*/
- (void)repeal{
    [self.allPathArray removeLastObject];
    [self setNeedsDisplay];
}
/**
 橡皮擦
 */
-(void)eraser{
    
//    for(DBUIBezierPath *path in self.allPathArray){
//
//    }
}
@end
