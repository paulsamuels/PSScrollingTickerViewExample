//
//  PSScrollingTickerViewExampleViewController.m
//  PSScrollingTickerViewExample
//
//  Created by Paul Samuels on 27/07/2011.
//  Copyright 2011 www.paul-samuels.com. All rights reserved.
//

#import "PSScrollingTickerViewExampleViewController.h"
#import "PSScrollingTickerView.h"

@implementation PSScrollingTickerViewExampleViewController

#pragma mark - View lifecycle

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  PSScrollingTickerView *tickerView = [[PSScrollingTickerView alloc] initWithFrame:CGRectMake(10, 10, 100, 50) 
                                                                              text:@"Hello, World! Hello, World! Hello, World! Hello, World! Hello, World!" 
                                                                             delay:2
                                                               scrollSpeedModifier:PSScrollingTickerViewFast];
  [self.view addSubview:tickerView];
  
  PSScrollingTickerView *tickerView2 = [[PSScrollingTickerView alloc] initWithFrame:CGRectMake(10, 70, 100, 50)];
  tickerView2.text = @"Hello, World! Hello, World! Hello, World! Hello, World! Hello, World!";
  tickerView2.delay = 4;
  tickerView2.speedModifier = PSScrollingTickerViewMedium;
  
  [self.view addSubview:tickerView2];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
