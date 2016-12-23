//
//  CounterViewController.m
//  GCD_demo
//
//  Created by Admin on 06/08/14.
//  Copyright (c) 2014 MyCompanyName. All rights reserved.
//

#import "CounterViewController.h"

@interface CounterViewController ()
@property (weak, nonatomic) IBOutlet UIButton *countButton;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
- (IBAction)startCount:(id)sender;

@end

@implementation CounterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    [self.spinner startAnimating];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startCount:(id)sender {
    __weak typeof(self) wself = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSInteger first = 0;
        NSInteger second = 1;
        NSInteger third = 0;
        while(YES){
            sleep(1);
            third = second + first;
            first = second;
            second = third;
            dispatch_sync(dispatch_get_main_queue(), ^{
                wself.label.text = [NSString stringWithFormat:@"%d",third];
            });
        }
    });
}
@end
