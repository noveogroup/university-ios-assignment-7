//
//  ViewController.m
//  Sequences
//
//  Created by admin on 20/07/16.
//  Copyright © 2016 Saveliy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *button;

@property (nonatomic, copy) void (^sequence)();
@property (nonatomic) NSOperationQueue *queue;

@end

@implementation ViewController

NSArray<NSNumber *> *getNumberOfSequence(NSInteger n, NSInteger j)
{
    NSArray<NSNumber *> *f;
    NSArray<NSNumber *> *g;
    if (n == 0) {
        return @[@1,@0];
    }
    else if (j < 1) {
        return @[@0, @0];
    }
    else if (j > n) {
        return getNumberOfSequence(n, j - 1);
    }
    else {
        f = getNumberOfSequence(n, j - 1);
        g = getNumberOfSequence(n - j, j);
        NSArray<NSNumber *> *result = @[@([f[0] integerValue]+[g[0] integerValue]),
                                        @([f[1] integerValue]+[g[1] integerValue]+[g[0] integerValue])];
        return result;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.label.text = @"";
    self.queue = [[NSOperationQueue alloc] init];
}


- (IBAction)tap:(id)sender
{
    [self.view endEditing:YES];
    
    [self.queue cancelAllOperations];
    [[NSOperationQueue mainQueue] cancelAllOperations];
    
    NSBlockOperation *countSequence = [[NSBlockOperation alloc] init];
    
    NSInteger n = [self.textField.text integerValue];
    __weak typeof(self) wself = self;
    __weak typeof(countSequence) wcountSequence = countSequence;
    self.sequence = ^{
        for (NSInteger i = 1; i <= n; i++) {
            @autoreleasepool {
                NSInteger numberOfSequence =
                [getNumberOfSequence(i,i)[1] integerValue] - [getNumberOfSequence(i-1,i-1)[1] integerValue];
                if (wcountSequence.isCancelled) {
                    return;
                }
                [[NSOperationQueue mainQueue] addOperationWithBlock: ^{
                    if (i == 1) {
                        wself.label.text =
                        [NSString stringWithFormat:@"%li : %ld", (long)i, (long)numberOfSequence];
                    }
                    else {
                        wself.label.text =
                        [NSString stringWithFormat:@"%li : %ld\n%@", (long)i, (long)numberOfSequence, wself.label.text];
                    }
                }];
            }
        }
    };
    [countSequence addExecutionBlock:self.sequence];
    
    [self.queue addOperation:countSequence];
}



@end
