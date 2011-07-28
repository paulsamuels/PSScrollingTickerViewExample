//
//  PSScrollingTickerView.h
//  PSScrollingTickerViewExample
//
//  Created by Paul Samuels on 27/07/2011.
//  Copyright 2011 www.paul-samuels.com. All rights reserved.
//

#import <UIKit/UIKit.h>

const float PSScrollingTickerViewFast;
const float PSScrollingTickerViewMedium;
const float PSScrollingTickerViewSlow;
const float PSScrollingTickerViewSuperSlow;

@interface PSScrollingTickerView : UIView

@property (nonatomic, copy)   NSString *text;
@property (nonatomic, assign) CGFloat  speedModifier;
@property (nonatomic, assign) CGFloat  delay;
@property (nonatomic, retain) UIFont   *font;
@property (nonatomic, retain) UIColor  *textColor;

- (id)initWithFrame:(CGRect)frame text:(NSString *)text delay:(CGFloat)delay scrollSpeedModifier:(CGFloat)tickerSpeedModifier font:(UIFont *)font;
- (void)scroll;

@end
