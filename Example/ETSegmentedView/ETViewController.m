//
//  ETViewController.m
//  ETSegmentedView
//
//  Created by Ersen Tekin on 03/30/2015.
//  Copyright (c) 2014 Ersen Tekin. All rights reserved.
//

#import "ETViewController.h"


@interface ETViewController ()

@end

@implementation ETViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ETSegmentedView* sv = [[ETSegmentedView alloc] initWithFrame:CGRectMake(10, 60, [[UIScreen mainScreen] bounds].size.width - 20, 260)];
    sv.nonSelectionColor = [UIColor whiteColor];
    sv.selectionColor = [UIColor darkGrayColor];
    [sv setTitles:@[@"One", @"Two", @"Three", @"Foro"]];
    
    NSMutableArray* arrayContents = [NSMutableArray new];
    
    for (int i = 0; i < 4; i++) {
        
        UILabel* lbl = [[UILabel alloc] initWithFrame:CGRectMake((i * sv.frame.size.width) + 10, 0, sv.frame.size.width - 20, sv.frame.size.height - 20)];
        NSString* str = [NSString stringWithFormat:@"Hello World - %d", i];
        [lbl setBackgroundColor:[UIColor greenColor]];
        [lbl setText:str];
        [arrayContents addObject:lbl];
    }
    
    [sv setContents:arrayContents];
    [self.view addSubview:sv];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnAnimateAction:(id)sender {
    
//    // 1. Pick a Kind Of Animation //  POPBasicAnimation  POPSpringAnimation POPDecayAnimation
//    POPSpringAnimation *basicAnimation = [POPSpringAnimation animation];
//    
//    basicAnimation.property = [POPAnimatableProperty propertyWithName: kPOPLayerPositionY];
//    basicAnimation.toValue = @(300.0f);
//    
//    basicAnimation.name = @"MinimizeViewHeight";
//    basicAnimation.delegate = self;
//    
//    // 5. Add animation to View or Layer, we picked View so self.tableView and not layer which would have been self.tableView.layer
//    [view pop_addAnimation:basicAnimation forKey:basicAnimation.name];


    
    
}

@end
