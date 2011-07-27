//
//  PSScrollingTickerView.m
//  PSScrollingTickerViewExample
//
//  Created by Paul Samuels on 27/07/2011.
//  Copyright 2011 www.paul-samuels.com. All rights reserved.
//

#import "PSScrollingTickerView.h"

const float PSScrollingTickerViewFast       = 0.02;
const float PSScrollingTickerViewMedium     = 0.035;
const float PSScrollingTickerViewSlow       = 0.045; 
const float PSScrollingTickerViewSuperSlow  = 0.055;

@interface PSScrollingTickerView ()

@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UILabel      *label;

- (void)configureTickerView;
- (void)scrollingTickerTapped:(id)sender;
- (void)animateScrollingTickerWithDelay:(BOOL)hasDelay;

@end

@implementation PSScrollingTickerView

@synthesize speedModifier = _speedModifier;
@synthesize text          = _text;
@synthesize delay         = _delay;
@synthesize scrollView    = _scrollView;
@synthesize label         = _label;

- (id)initWithFrame:(CGRect)frame
{
  return [self initWithFrame:frame text:nil delay:0 scrollSpeedModifier:PSScrollingTickerViewMedium];
}

- (id)initWithFrame:(CGRect)frame text:(NSString *)text delay:(CGFloat)delay scrollSpeedModifier:(CGFloat)tickerSpeedModifier
{
  self = [super initWithFrame:frame];
  if (self) {
    _speedModifier = tickerSpeedModifier;
    _delay = delay;
    _text  = [text copy];
  }
  return self;
}

- (void)dealloc
{
  [_text release];
  [super dealloc];
}

- (void)didMoveToSuperview
{
  [self configureTickerView];
  
  if ([[UIView class] respondsToSelector:@selector(animateWithDuration:delay:options:animations:completion:)]) {
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] init];
    
    [tapGestureRecognizer addTarget:self action:@selector(scrollingTickerTapped:)];
    [self.scrollView addGestureRecognizer:tapGestureRecognizer];
    [tapGestureRecognizer release]; tapGestureRecognizer = nil;
    [self animateScrollingTickerWithDelay:YES];
  }
}

- (void)configureTickerView
{
  [self.scrollView removeFromSuperview];
  
  float maxAllowedWidth = self.frame.size.width;
  
  CGSize labelSize = [self.text sizeWithFont:[UIFont boldSystemFontOfSize: 20]
                      constrainedToSize:CGSizeMake(NSIntegerMax, self.frame.size.height) 
                          lineBreakMode:UILineBreakModeWordWrap];
  
  if (labelSize.width > maxAllowedWidth) {
    
    UILabel *labelView        = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, labelSize.width, self.frame.size.height)];
    
    labelView.text            = self.text;
    labelView.font            = [UIFont boldSystemFontOfSize:20.0];
    labelView.backgroundColor = [UIColor clearColor];
    labelView.textColor       = [UIColor whiteColor];
    labelView.shadowColor     = [UIColor grayColor];
    
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator   = NO;
    scrollView.contentSize                    = CGSizeMake(labelSize.width, self.frame.size.height);
    
    [scrollView addSubview:labelView];
    self.label = labelView;
    [labelView release]; labelView = nil;
    
    [self addSubview:scrollView];
    self.scrollView = scrollView;
    [scrollView release]; scrollView = nil;
  }
}

- (void)scrollingTickerTapped:(id)sender
{
  if ([[UIView class] respondsToSelector:@selector(animateWithDuration:delay:options:animations:completion:)]) {
    [self animateScrollingTickerWithDelay:NO];
  }
}

- (void)animateScrollingTickerWithDelay:(BOOL)hasDelay
{
  UIScrollView *scrollView = self.scrollView;
  
  float endPosition = scrollView.contentSize.width - scrollView.bounds.size.width;
  float duration = endPosition * self.speedModifier;
  
  CGFloat delay = hasDelay ? self.delay : 0;
    
  [UIView animateWithDuration:duration 
                        delay:delay 
                      options:UIViewAnimationCurveLinear
                   animations:^{
                     scrollView.contentOffset = CGPointMake(endPosition, 0);
                   }
                   completion:^(BOOL finished){
                     [UIView animateWithDuration:0.5
                                           delay:1
                                         options:UIViewAnimationCurveLinear
                                      animations:^{
                                        scrollView.contentOffset = CGPointZero;
                                      }
                                      completion:^(BOOL finished){}];
                   }];
}

@end
