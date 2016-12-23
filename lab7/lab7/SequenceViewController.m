//
//  SequenceViewController.m
//  lab7
//
//  Created by Admin on 09/08/14.
//  Copyright (c) 2014 Noveo Summer Internship. All rights reserved.
//

#import "SequenceViewController.h"
#import "SequenceGenerator.h"

@interface SequenceViewController ()

@property (nonatomic, weak) IBOutlet UILabel *numberLabel;
@property (nonatomic, weak) IBOutlet UILabel *valueLabel;

@end

@implementation SequenceViewController

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
    
    NSThread *sequenceThread = [[NSThread alloc]
        initWithTarget:self
        selector:@selector(startSequence)
        object:nil
    ];
    
    [sequenceThread start];
}

- (void)startSequence {
    SequenceGenerator *sequenceGenerator = [[SequenceGenerator alloc] init];
    
    while (YES) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.numberLabel.text = [NSString stringWithFormat:@"%d:", sequenceGenerator.index];
            self.valueLabel.text = [NSString stringWithFormat:@"%@", sequenceGenerator.value];
        });
        
        usleep(500000);
        
        [sequenceGenerator next];
    }
}

@end
