//
//  VC.m
//  7lab
//
//  Created by Admin on 14/08/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "VC.h"

@interface VC ()

@property (atomic) NSInteger number;

@property (nonatomic, weak) IBOutlet UILabel *numberLabel;

@end

@implementation VC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.number = 0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSThread *numbersThread = [[NSThread alloc] initWithTarget:self
                            selector:@selector(go) object:nil];
    
    [numbersThread start];
}

- (void)go
{
    while (YES) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.numberLabel.text = [NSString stringWithFormat:@"%d", [self fib : self.number]];
            self.number++;
        });
        
        usleep(100000);
    }
}


-(NSInteger)fib:(NSInteger) number
{
    if(number == 0 || number == 1)
    {
        return number;
    }
    
    else
    {
        return [self fib:(number - 2)] + [self fib: (number - 1)];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
