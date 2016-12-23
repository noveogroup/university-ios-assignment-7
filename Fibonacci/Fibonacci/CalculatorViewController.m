//
//  CalculatorViewController.m
//  Fibonacci
//
//  Created by Иван Букшев on 3/17/15.
//  Copyright (c) 2015 Ivan Bukshev. All rights reserved.
//

#import "CalculatorViewController.h"

#define TIME_TICK 500000

@interface CalculatorViewController ()

@end

@implementation CalculatorViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.view.backgroundColor = [UIColor lightGrayColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)countButtonTouchUp:(UIButton *)sender
{
    [sender setEnabled:NO];
    [sender setTitle:@"Thread launched" forState:UIControlStateDisabled];
    
    __typeof(self) __weak weakSelf = self;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSUInteger first = 0, second = 1, summ = 0;
        
        while (YES)
        {
            summ = first + second;
            first = second;
            second = summ;
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                weakSelf.resultLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)summ];
            });
            
            usleep(TIME_TICK);
        };
    });
}


@end
