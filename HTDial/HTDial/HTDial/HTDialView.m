//
//  HTDialView.m
//  HTDial
//
//  Created by chenghong on 2017/8/8.
//  Copyright © 2017年 HT. All rights reserved.
//

#import "HTDialView.h"

@interface HTDialView ()

@property (nonatomic, strong) UIView *pointerView;

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
    
    // Dial image
    UIImageView *dialBgImgView = [[UIImageView alloc] initWithFrame:self.bounds];
    dialBgImgView.image = [UIImage imageNamed:@"dial_bg"];
    [self addSubview:dialBgImgView];
    
    // Pointer init
    self.pointerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 3, 80)];
    [self.pointerView setCenter:dialBgImgView.center];
    self.pointerView.backgroundColor = [UIColor yellowColor];
    self.pointerView.layer.anchorPoint = CGPointMake(0.5, 0.25);
    self.pointerView.layer.masksToBounds = YES;
    self.pointerView.layer.shouldRasterize = YES;
    self.pointerView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    [self addSubview:self.pointerView];
    
}

// Draw areas in different colors
- (void)drawAreas {
    
    if (self.minValue == self.maxValue) {
        
        return;
    
    }
    
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGSize viewSize = self.bounds.size;
    CGPoint center = CGPointMake(viewSize.width/2, viewSize.height/2);
    CGFloat radius = viewSize.width/2;
    
    // Draw low area
    CGFloat lowAreaAngle = (self.firstSeparationValue - self.minValue)/(self.maxValue - self.minValue) * (1.5 * M_PI);
    
    CGContextBeginPath(contextRef);
    CGContextMoveToPoint(contextRef, center.x, center.y);
    CGContextAddArc(contextRef, center.x, center.y, radius, M_PI_2, M_PI_2 + lowAreaAngle, 0);
    CGContextSetFillColorWithColor(contextRef, [UIColor colorWithRed:0/255.0 green:102.0/255.0 blue:255.0/255.0 alpha:1.0].CGColor);
    CGContextFillPath(contextRef);
    
    // Draw middle area
    CGFloat middleAreaAngle = (self.secondSeparationValue - self.firstSeparationValue)/(self.maxValue - self.minValue) * (1.5 * M_PI);
    
    CGContextBeginPath(contextRef);
    CGContextMoveToPoint(contextRef, center.x, center.y);
    CGContextAddArc(contextRef, center.x, center.y, radius, M_PI_2 + lowAreaAngle, M_PI_2 + lowAreaAngle + middleAreaAngle, 0);
    CGContextSetFillColorWithColor(contextRef, [UIColor colorWithRed:13/255.0 green:142/255.0 blue:0/255.0 alpha:1.0].CGColor);
    CGContextFillPath(contextRef);
    
    // Draw high area
    CGContextBeginPath(contextRef);
    CGContextMoveToPoint(contextRef, center.x, center.y);
    CGContextAddArc(contextRef, center.x, center.y, radius, M_PI_2 + lowAreaAngle + middleAreaAngle, M_PI * 2, 0);
    CGContextSetFillColorWithColor(contextRef, [UIColor colorWithRed:250/255.0 green:47/255.0 blue:47/255.0 alpha:1.0].CGColor);
    CGContextFillPath(contextRef);
    
    // Draw mask round
    CGContextBeginPath(contextRef);
    CGContextMoveToPoint(contextRef, center.x, center.y);
    CGContextAddArc(contextRef, center.x, center.y, radius * 0.8, 0, M_PI * 2, 0);
    CGContextSetFillColorWithColor(contextRef, self.backgroundColor.CGColor);
    CGContextFillPath(contextRef);
    
}

// Point to a value
- (void)pointValue:(CGFloat)value {
    
    if (self.minValue == self.maxValue || value < self.minValue || value > self.maxValue) {
        
        return;
        
    }
    
    [UIView animateWithDuration:1.0 animations:^{
        
        CGFloat angle = ((value - self.minValue)/(self.maxValue - self.minValue)) * (M_PI * 1.5);
        
        if (angle > M_PI) {
            
            // angle > 180°, rotate in two steps
            self.pointerView.transform = CGAffineTransformMakeRotation(M_PI);
            self.pointerView.transform = CGAffineTransformMakeRotation(angle);
            
        } else {
            
            // angle <= 180°, rotate once
            self.pointerView.transform = CGAffineTransformMakeRotation(angle);
            
        }
    }];
}





@end
