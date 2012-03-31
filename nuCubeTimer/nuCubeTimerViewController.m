//
//  nuCubeTimerViewController.m
//  nuCubeTimer
//
//  Created by Jian Hua Chen on 12/3/31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "nuCubeTimerViewController.h"

@interface nuCubeTimerViewController ()

@end

@implementation nuCubeTimerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
