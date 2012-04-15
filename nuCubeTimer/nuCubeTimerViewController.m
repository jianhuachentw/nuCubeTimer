//
//  nuCubeTimerViewController.m
//  nuCubeTimer
//
//  Created by Jian Hua Chen on 12/3/31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "nuCubeTimerViewController.h"

@interface nuCubeTimerViewController ()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property NSTimer *timer;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
@property BOOL stoppingTimer;
@property int timeValue;
@end

@implementation nuCubeTimerViewController

@synthesize timeLabel = _timeLabel;
@synthesize timer = _timer;
@synthesize stoppingTimer = _stoppingTimer;
@synthesize timeValue = _timeValue;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    NSLog(@"touchesBegan");
    if ([self.timer isValid]) {
        [self.timer invalidate];
        self.stoppingTimer = TRUE;
        self.timeValue = 0;
    } else {
        self.view.backgroundColor = [UIColor blueColor];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"touchesEnded");
    if (self.stoppingTimer == TRUE) {
        self.stoppingTimer = FALSE;
    } else if (![self.timer isValid]) {
        self.timer=[NSTimer scheduledTimerWithTimeInterval:0.01 
                                           target:self 
                                         selector:@selector(updateLabel) 
                                         userInfo:nil 
                                          repeats:YES];
    }
}


- (void)viewDidLoad
{
    NSLog(@"viewDidLoad");
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //self.TapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    //[self.view addGestureRecognizer:self.tapRecognizer];


}

- (void) updateLabel
{
    self.timeValue++;
    self.timeLabel.text = [NSString stringWithFormat:@"%02d:%02d", self.timeValue / 100, self.timeValue % 100];
}

- (void)viewDidUnload
{
    [self setTimeLabel:nil];
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
