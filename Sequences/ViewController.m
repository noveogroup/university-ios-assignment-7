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

@end

@implementation ViewController

NSArray<NSNumber *> *b(NSInteger n, NSInteger j) {
    NSArray<NSNumber *> *f;
    NSArray<NSNumber *> *g;
    if (n == 0) {
        return @[@1,@0];
    }
    else if (j < 1) {
        return @[@0, @0];
    }
    else if (j > n) {
        return b(n, j - 1);
    }
    else {
        f = b(n, j - 1);
        g = b(n - j, j);
        NSArray<NSNumber *> *result = @[@([f[0] integerValue]+[g[0] integerValue]),
                                        @([f[1] integerValue]+[g[1] integerValue]+[g[0] integerValue])];
        return result;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.label.text = @"";
    ViewController __weak *weakSelf = self;
    self.sequence = ^{
        NSInteger n = [weakSelf.textField.text integerValue];
        for (NSInteger i =1; i <= n; i++) {
            NSInteger a = [b(i,i)[1] integerValue] - [b(i-1,i-1)[1] integerValue];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (i == 1) {
                    weakSelf.label.text =
                    [NSString stringWithFormat:@"%li : %ld", (long)i, (long)a];
                }
                else {
                    weakSelf.label.text =
                    [NSString stringWithFormat:@"%@\n%li : %ld",weakSelf.label.text, (long)i, (long)a];
                }
            });
        }
    };
}


- (IBAction)tap:(id)sender {
    [self.view endEditing:YES];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, self.sequence);
}



@end
