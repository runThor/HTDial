//
//  HTDialView.h
//  HTDial
//
//  Created by chenghong on 2017/8/8.
//  Copyright © 2017年 HT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTDialView : UIView

@property (nonatomic, assign) CGFloat minValue;  // 最小值
@property (nonatomic, assign) CGFloat maxValue;  // 最大值
@property (nonatomic, assign) CGFloat firstSeparationValue;  // 第一个分界点的值
@property (nonatomic, assign) CGFloat secondSeparationValue;  // 第二个分界点的值

// 指针指向某个值
- (void)pointValue:(CGFloat)value;

@end
