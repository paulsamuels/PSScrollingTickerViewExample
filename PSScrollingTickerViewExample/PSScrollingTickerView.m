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
@synthesize font          = _font;
@synthesize textColor     = _textColor;
@synthesize scrollView    = _scrollView;
@synthesize label         = _label;

#pragma mark -
#pragma mark Object lifecycle

- (id)initWithFrame:(CGRect)frame
{
  return [self initWithFrame:frame text:nil delay:0 scrollSpeedModifier:PSScrollingTickerViewMedium font:nil];
}

- (id)initWithFrame:(CGRect)frame text:(NSString *)text delay:(CGFloat)delay scrollSpeedModifier:(CGFloat)tickerSpeedModifier font:(UIFont *)font
{
  self = [super initWithFrame:frame];
  if (self) {
    _speedModifier = tickerSpeedModifier;
    _delay = delay;
    _text  = [text copy];
    _font  = font ? font : [UIFont boldSystemFontOfSize: 20];
  }
  return self;
}

- (void)dealloc
{
  [_text      release];
  [_font      release];
  [_textColor release];
  [super dealloc];
}

#pragma mark -
#pragma mark Configuration and Display

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
  
  CGSize labelSize = [self.text sizeWithFont:self.font
                      constrainedToSize:CGSizeMake(NSIntegerMax, self.frame.size.height) 
                          lineBreakMode:UILineBreakModeWordWrap];
  
  UILabel *labelView        = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, labelSize.width, self.frame.size.height)];
  
  labelView.text            = self.text;
  labelView.font            = self.font;
  labelView.backgroundColor = [UIColor clearColor];
  labelView.textColor       = self.textColor ? self.textColor : [UIColor whiteColor];
  labelView.shadowColor     = [UIColor grayColor];
  
  if (labelSize.width > maxAllowedWidth) {

    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator   = NO;
    scrollView.contentSize                    = CGSizeMake(labelSize.width, self.frame.size.height);
    
    [scrollView addSubview:labelView];
    
    [self addSubview:scrollView];
    self.scrollView = scrollView;
    [scrollView release]; scrollView = nil;
  } else {
    [self addSubview:labelView];
  }
  
  self.label = labelView;
  [labelView release]; labelView = nil;
}

#pragma mark -
#pragma mark Animation and tap handling

- (void)scroll
{
  [self scrollingTickerTapped:nil];
}

- (void)scrollingTickerTapped:(id)sender
{
  if (self.scrollView) {
    if ([[UIView class] respondsToSelector:@selector(animateWithDuration:delay:options:animations:completion:)]) {
      [self animateScrollingTickerWithDelay:NO];
    }
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
