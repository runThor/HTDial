//
//  HTDialView.m
//  HTDial
//
//  Created by chenghong on 2017/8/8.
//  Copyright © 2017年 HT. All rights reserved.
//

#import "HTDialView.h"

@interface HTDialView ()

@property (nonatomic, strong) UIView *pointerView;  // 指针

@end


@implementation HTDialView

- (void)drawRect:(CGRect)rect {
    
    [self drawAreas];
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self configViews];
        
    }
    
    return self;
}

- (void)configViews {
    
    // 表盘边框
    UIImageView *dialBgImgView = [[UIImageView alloc] initWithFrame:self.bounds];
    dialBgImgView.image = [UIImage imageNamed:@"dial_bg"];
    [self addSubview:dialBgImgView];
    
    // 初始化指针
    self.pointerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 3, 80)];
    [self.pointerView setCenter:dialBgImgView.center];
    self.pointerView.backgroundColor = [UIColor yellowColor];
    self.pointerView.layer.anchorPoint = CGPointMake(0.5, 0.25);
    self.pointerView.layer.masksToBounds = YES;
    self.pointerView.layer.shouldRasterize = YES;
    self.pointerView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    [self addSubview:self.pointerView];
    
}

// 以不同颜色划分区域
- (void)drawAreas {
    
    if (self.minValue == self.maxValue) {
        
        return;
    
    }
    
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGSize viewSize = self.bounds.size;
    CGPoint center = CGPointMake(viewSize.width/2, viewSize.height/2);
    CGFloat radius = viewSize.width/2;
    
    // 绘制lowArea
    CGFloat lowAreaAngle = (self.firstSeparationValue - self.minValue)/(self.maxValue - self.minValue) * (1.5 * M_PI);
    
    CGContextBeginPath(contextRef);
    CGContextMoveToPoint(contextRef, center.x, center.y);
    CGContextAddArc(contextRef, center.x, center.y, radius, M_PI_2, M_PI_2 + lowAreaAngle, 0);
    CGContextSetFillColorWithColor(contextRef, [UIColor colorWithRed:0/255.0 green:102.0/255.0 blue:255.0/255.0 alpha:1.0].CGColor);
    CGContextFillPath(contextRef);
    
    // 绘制middleArea
    CGFloat middleAreaAngle = (self.secondSeparationValue - self.firstSeparationValue)/(self.maxValue - self.minValue) * (1.5 * M_PI);
    
    CGContextBeginPath(contextRef);
    CGContextMoveToPoint(contextRef, center.x, center.y);
    CGContextAddArc(contextRef, center.x, center.y, radius, M_PI_2 + lowAreaAngle, M_PI_2 + lowAreaAngle + middleAreaAngle, 0);
    CGContextSetFillColorWithColor(contextRef, [UIColor colorWithRed:13/255.0 green:142/255.0 blue:0/255.0 alpha:1.0].CGColor);
    CGContextFillPath(contextRef);
    
    // 绘制highArea
    CGContextBeginPath(contextRef);
    CGContextMoveToPoint(contextRef, center.x, center.y);
    CGContextAddArc(contextRef, center.x, center.y, radius, M_PI_2 + lowAreaAngle + middleAreaAngle, M_PI * 2, 0);
    CGContextSetFillColorWithColor(contextRef, [UIColor colorWithRed:250/255.0 green:47/255.0 blue:47/255.0 alpha:1.0].CGColor);
    CGContextFillPath(contextRef);
    
    // 绘制遮罩圆
    CGContextBeginPath(contextRef);
    CGContextMoveToPoint(contextRef, center.x, center.y);
    CGContextAddArc(contextRef, center.x, center.y, radius * 0.8, 0, M_PI * 2, 0);
    CGContextSetFillColorWithColor(contextRef, self.backgroundColor.CGColor);
    CGContextFillPath(contextRef);
    
}

// 指针指向某个值
- (void)pointValue:(CGFloat)value {
    
    if (self.minValue == self.maxValue || value < self.minValue || value > self.maxValue) {
        
        return;
        
    }
    
    [UIView animateWithDuration:1.0 animations:^{
        
        CGFloat angle = ((value - self.minValue)/(self.maxValue - self.minValue)) * (M_PI * 1.5);
        
        if (angle > M_PI) {
            
            // 旋转角度大于180°的情况，分两段旋转
            self.pointerView.transform = CGAffineTransformMakeRotation(M_PI);
            self.pointerView.transform = CGAffineTransformMakeRotation(angle);
            
        } else {
            
            // 旋转角度不大于180°的情况，一次旋转到位
            self.pointerView.transform = CGAffineTransformMakeRotation(angle);
            
        }
    }];
}





@end
