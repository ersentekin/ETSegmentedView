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
    [sv.layer setCornerRadius:sv.viewButtons.layer.cornerRadius];
    [sv.layer setBorderWidth:1.0f];
    
    [sv.layer setBorderColor:[UIColor colorWithWhite:0.8 alpha:1].CGColor];
    [sv setBackgroundColor:[UIColor colorWithWhite:0.92 alpha:1]];
    
    sv.selectionColor = [UIColor darkGrayColor];
    [sv setTitles:@[@"Label", @"Image", @"WebView", @"Custom"]];
    
    NSMutableArray* arrayContents = [NSMutableArray new];
    
    UILabel* lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, sv.frame.size.width - 20, sv.frame.size.height - 20)];
    NSString* str = [NSString stringWithFormat:@"ETSegmentedView is lightweight segmented view similar to Apple's with some cool features. Segments and content are scrolling synchronously. It uses POP animation framework by Facebook. It's an easy-to-setup view component for iOS projects. So clone the repo and run the example project to give a shot!"];
    [lbl setText:str];
    [lbl setFont:[UIFont fontWithName:@"HelveticaNeue" size:15.0f]];
    [lbl setTextColor:[UIColor darkGrayColor]];
    [lbl setNumberOfLines:0];
    [arrayContents addObject:lbl];
    
    UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, sv.frame.size.width - 20, sv.frame.size.height - 55)];
    [imageView setImage:[UIImage imageNamed:@"photo1.jpg"]];
    [arrayContents addObject:imageView];
    
    UIWebView* webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, sv.frame.size.width, sv.frame.size.height - sv.viewButtons.frame.size.height)];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://github.com"]]];
    [arrayContents addObject:webView];
    
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, sv.frame.size.width, sv.frame.size.height - sv.viewButtons.frame.size.height)];
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped)];
    [customView addGestureRecognizer:tap];
    
    UILabel* lblCustomView = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, customView.frame.size.width, 30)];
    [lblCustomView setFont:[UIFont fontWithName:@"HelveticaNeue" size:13.0f]];
    [lblCustomView setText:@"Contact Form"];
    [lblCustomView setTextAlignment:NSTextAlignmentCenter];
    [customView addSubview:lblCustomView];
    
    UITextField* textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 60, sv.frame.size.width - 20, 100)];
    [textField setBackgroundColor:[UIColor whiteColor]];
    [textField setFont:[UIFont fontWithName:@"HelveticaNeue" size:13.0f]];
    [customView addSubview:textField];
    
    UIButton* btnSubmit = [[UIButton alloc] initWithFrame:CGRectMake(10, textField.frame.size.height + textField.frame.origin.y + 10, sv.frame.size.width - 20, 40)];
    [btnSubmit setTitle:@"Submit" forState:UIControlStateNormal];
    [btnSubmit setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnSubmit setBackgroundColor:[UIColor colorWithRed:203.0f/255.0f green:233.0f/255.0f blue:183.0f/255.0f alpha:1]];
    [btnSubmit.layer setCornerRadius:4.0f];
    [customView addSubview:btnSubmit];
    
    [arrayContents addObject:customView];
    
    [sv setContents:arrayContents];
    [self.view addSubview:sv];
    
}

-(void)viewTapped {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
