//
//  ViewController.m
//  Task7
//
//  Created by Sergey Plotnikov on 21.07.16.
//  Copyright © 2016 Sergey Plotnikov. All rights reserved.
//

//int a = x*(-3+2*x+5x^2+7*x^3+8*x^4)/(1-x-x^3-x^5);


#import "ViewController.h"

@interface ViewController ()

@property (nonatomic) NSOperationQueue *queue;

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton*startButton;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _queue = [[NSOperationQueue alloc] init];
}

- (NSInteger)fibonacci:(NSInteger)n
{
    return (n <= 2 ? 1 : [self fibonacci:(n-1)] + [self fibonacci:(n-2)]);
}

- (IBAction)startAction:(id)sender
{
    [self.view endEditing:YES];
    [self.queue cancelAllOperations];
    [self.startButton setEnabled:NO];
    [self.stopButton setEnabled:YES];
    NSBlockOperation *operation = [[NSBlockOperation alloc] init];
    NSInteger n = [self.textField.text integerValue];
    __weak typeof(self) weakSelf = self;
    __weak NSBlockOperation *weakOperation = operation;
    [operation addExecutionBlock:^{
        for (NSUInteger i = 0; i < n; i++) {
            if ([weakOperation isCancelled]) break;
                NSInteger number = (long)[weakSelf fibonacci:i];
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                if ([weakOperation isCancelled]) return;
                weakSelf.textView.text = [[NSString stringWithFormat: @"%i\n", number] stringByAppendingString:weakSelf.textView.text];
            }];
        }
    }];
    
    [self.queue addOperation:operation];
}

- (IBAction)stopAction:(id)sender
{
    [self.queue cancelAllOperations];
    [self.stopButton setEnabled:NO];
    [self.startButton setEnabled:YES];
    self.textView.text = @"";
}

@end
