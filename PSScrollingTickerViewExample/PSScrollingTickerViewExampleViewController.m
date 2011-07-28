//
//  PSScrollingTickerViewExampleViewController.m
//  PSScrollingTickerViewExample
//
//  Created by Paul Samuels on 27/07/2011.
//  Copyright 2011 www.paul-samuels.com. All rights reserved.
//

#import "PSScrollingTickerViewExampleViewController.h"
#import "PSScrollingTickerView.h"

@interface PSScrollingTickerViewExampleViewController ()

@property (nonatomic, retain) PSScrollingTickerView *tickerView;

- (void)configureScrollingTickerUsingDesignatedInitMethod;
- (void)configureScrollingTickerTheLongWay;

@end

@implementation PSScrollingTickerViewExampleViewController

@synthesize tickerView = _tickerView;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  [self configureScrollingTickerUsingDesignatedInitMethod];
  
  [self configureScrollingTickerTheLongWay];
}

- (void)configureScrollingTickerUsingDesignatedInitMethod
{
  PSScrollingTickerView *tickerView = [[PSScrollingTickerView alloc] initWithFrame:CGRectMake(20, 28, 200, 50) 
                                                                              text:@"Hello, World! Hello, World! Hello, World! Hello, World! Hello, World!" 
                                                                             delay:2
                                                               scrollSpeedModifier:PSScrollingTickerViewFast 
                                                                              font:nil];
  self.tickerView = tickerView;
  [self.view addSubview:tickerView];
  [tickerView release]; tickerView = nil;
}

- (void)configureScrollingTickerTheLongWay
{
  PSScrollingTickerView *tickerView2 = [[PSScrollingTickerView alloc] initWithFrame:CGRectMake(20, 140, 280, 50)];
  tickerView2.text = @"Hello, World! Hello, World!";
  tickerView2.delay = 4;
  tickerView2.speedModifier = PSScrollingTickerViewMedium;
  tickerView2.font = [UIFont systemFontOfSize:18];
  tickerView2.textColor = [UIColor purpleColor];
  
  [self.view addSubview:tickerView2];
  [tickerView2 release]; tickerView2 = nil;
}

- (IBAction)scrollTapped:(id)sender
{
  [self.tickerView scroll];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
