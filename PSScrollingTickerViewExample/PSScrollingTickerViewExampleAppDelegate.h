//
//  PSScrollingTickerViewExampleAppDelegate.h
//  PSScrollingTickerViewExample
//
//  Created by Paul Samuels on 27/07/2011.
//  Copyright 2011 www.paul-samuels.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PSScrollingTickerViewExampleViewController;

@interface PSScrollingTickerViewExampleAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet PSScrollingTickerViewExampleViewController *viewController;

@end
