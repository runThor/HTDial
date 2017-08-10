//
//  HTDialView.h
//  HTDial
//
//  Created by chenghong on 2017/8/8.
//  Copyright © 2017年 HT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTDialView : UIView

@property (nonatomic, assign) CGFloat minValue;
@property (nonatomic, assign) CGFloat maxValue;
@property (nonatomic, assign) CGFloat firstSeparationValue;
@property (nonatomic, assign) CGFloat secondSeparationValue;

// Point to a value
- (void)pointValue:(CGFloat)value;

@end
