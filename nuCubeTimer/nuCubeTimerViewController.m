//
//  nuCubeTimerViewController.m
//  nuCubeTimer
//
//  Created by Jian Hua Chen on 12/3/31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "nuCubeTimerViewController.h"
#import "CubeTimeRecord+Create.h"
#import "Cuber+Create.h"

@interface nuCubeTimerViewController ()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property NSTimer *timer;
@property BOOL stoppingTimer;
@property int timeValue;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *cuberNameField;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
@end

@implementation nuCubeTimerViewController

@synthesize timeLabel = _timeLabel;
@synthesize timer = _timer;
@synthesize stoppingTimer = _stoppingTimer;
@synthesize timeValue = _timeValue;
@synthesize tableView = _tableView;
@synthesize cuberNameField = _cuberNameField;
@synthesize recordDataBase = _recordDataBase;

- (void) setupFetchedResultsController
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"CubeTimeRecord"];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"time" ascending:YES]];
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.recordDataBase.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
}

- (void) addFakeDataIntoDocument:(UIManagedDocument *)document
{
    dispatch_queue_t fakeQ = dispatch_queue_create("cube time faker", NULL);
    dispatch_async(fakeQ, ^{
        [document.managedObjectContext performBlock:^{
            [CubeTimeRecord cubeTimeRecordWithTime:[NSNumber numberWithInt:30] inManagedObjectContext:document.managedObjectContext];
        }];
    });
}

- (void) useDocument
{
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:[self.recordDataBase.fileURL path]]) {
        [self.recordDataBase saveToURL:self.recordDataBase.fileURL forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
            [self setupFetchedResultsController];
        }];
    } else if (self.recordDataBase.documentState == UIDocumentStateClosed) {
        [self.recordDataBase openWithCompletionHandler:^(BOOL success) {
            [self setupFetchedResultsController];
        }];
    } else if (self.recordDataBase.documentState == UIDocumentStateNormal) {
        [self setupFetchedResultsController];
    }
    
}

- (void) setRecordDataBase:(UIManagedDocument *)recordDataBase
{
    if (_recordDataBase != recordDataBase) {
        _recordDataBase = recordDataBase;
        [self useDocument];
    }
}

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
 
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!self.recordDataBase) {
        NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        url = [url URLByAppendingPathComponent:@"Default Photo Database"];
        
        NSLog(@" -------------- %p  %@-------------- \n", url, [url lastPathComponent]);
        

        UIManagedDocument *document;
        document = [[UIManagedDocument alloc] initWithFileURL:url];  // ALWAYS CRASH at this line!!!!
        //NSLog(@"%p", document);
        self.recordDataBase = document;
    }
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString *CellIdentifier = @"Record Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // configure the cell
    CubeTimeRecord *record = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = record.whoCreate.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", record.time];
    
    return cell;
}

- (IBAction)onCuberNameChanged:(id)sender {
    NSLog(@"onCuberNameChanged");

    
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
    [self setTableView:nil];
    [self setCuberNameField:nil];
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
