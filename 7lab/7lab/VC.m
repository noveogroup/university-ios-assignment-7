//
//  VC.m
//  7lab
//
//  Created by Admin on 14/08/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "VC.h"

@interface VC ()

@end

@implementation VC

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
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
    dispatch_async(queue, ^{
        NSInteger num = [self fib:1];
        dispatch_sync(dispatch_get_main_queue(), ^{
            // Update UI
            // Example:
            // self.myLabel.text = result;
        });
    });
    // Do any additional setup after loading the view from its nib.
}

-(NSInteger)fib:(NSInteger) number
{
    if(number == 0 || 1)
    {
        return number;
    }
    
    else
    {
        return number + [self fib: number - 1];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
