#import "ViewController.h"
#import "TriangularNumber.h"


@interface ViewController ()

@property (strong, nonatomic) IBOutlet UILabel *numberLabel;
@property (strong, nonatomic) TriangularNumber *number;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.number = [[TriangularNumber alloc] init];
    
    CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self
                                                             selector:@selector(updateNumberLabel)];
    
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
    NSThread *sequenceCalculatingThread = [[NSThread alloc] initWithTarget:self
                                                                  selector:@selector(runCalculating)
                                                                    object:nil];

    [sequenceCalculatingThread start];
}

- (void) updateNumberLabel {
    self.numberLabel.text = [NSString stringWithFormat:@"a(%ld) = %llu",
                             (long)self.number.positionInSequence, self.number.value];
}

- (void)runCalculating {
    while (YES) {
        [self.number calculateNextValue];
    }
}

@end
