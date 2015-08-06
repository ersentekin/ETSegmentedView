//
//  UserInterfaceExampleViewController.h
//  ETSegmentedView
//
//  Created by Ersen Tekin on 06/08/15.
//  Copyright (c) 2015 Ersen Tekin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ETSegmentedView/ETSegmentedView.h>

@interface UserInterfaceExampleViewController : UIViewController

@property (strong, nonatomic) IBOutlet ETSegmentedView *segmentedView;
- (IBAction)btnCloseTapped:(id)sender;

@end
