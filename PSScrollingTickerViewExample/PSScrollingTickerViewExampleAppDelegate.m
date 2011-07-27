//
//  PSScrollingTickerViewExampleAppDelegate.m
//  PSScrollingTickerViewExample
//
//  Created by Paul Samuels on 27/07/2011.
//  Copyright 2011 www.paul-samuels.com. All rights reserved.
//

#import "PSScrollingTickerViewExampleAppDelegate.h"
#import "PSScrollingTickerViewExampleViewController.h"

@implementation PSScrollingTickerViewExampleAppDelegate

@synthesize window         = _window;
@synthesize viewController = _viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{  
  self.window.rootViewController = self.viewController;
  [self.window makeKeyAndVisible];
  return YES;
}

- (void)dealloc
{
  [_window         release];
  [_viewController release];
  [super dealloc];
}

@end
