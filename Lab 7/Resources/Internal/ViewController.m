
#import "ViewController.h"

static double const goodPi = 3.14159265358979323846;

@interface ViewController ()

@property (nonatomic, strong) NSThread *thread;

@property (nonatomic, assign) NSInteger n;
@property (nonatomic, assign) double lastStep;
@property (nonatomic, assign) double pi;

@property (nonatomic, assign) BOOL working;
@property (nonatomic, assign) BOOL pause;

@property (weak, nonatomic) IBOutlet UILabel *piLabel;
@property (weak, nonatomic) IBOutlet UILabel *nLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self startCalculation];
    [self startVisualization];
}

- (IBAction)pauseAction:(id)sender {
    self.pause = !self.pause;
}

- (IBAction)startAgainAction:(id)sender {
    self.working = NO;
    
    [self performSelector:@selector(startCalculation) withObject:nil afterDelay:0.2];
}

#pragma mark - calculation

- (void) startCalculation
{
    self.n = 0;
    self.pi = 0;
    self.lastStep = 1;
    self.thread = [[NSThread alloc] initWithTarget:self selector:@selector(calculate) object:nil];
    
    self.working = YES;
    self.pause = NO;
    
    [self.thread start];
    
}

- (void) calculate
{
    while (self.lastStep > pow(10, -10) || self.lastStep < -pow(10, -10)) {
        
        if (!self.pause && self.working) {
            double nextStep = pow(-1, self.n)*4/(2*self.n + 1);
            self.pi += nextStep;
            self.n++;
            self.lastStep = nextStep;
        } else if (!self.working){
            [NSThread exit];
        }
    }
}

#pragma mark - visualization

- (void) startVisualization
{
    [self performSelector:@selector(visualize) withObject:nil afterDelay:0.04];
}

- (void) visualize
{
    if (self.working) {
        NSString* currentPiString = [@(self.pi) stringValue];
        NSString* goodPiString = [@(goodPi) stringValue];
        
        NSMutableAttributedString* string = [[NSMutableAttributedString alloc] initWithString:currentPiString];
        NSInteger length = [currentPiString length];

        for (int i = 0; i < length - 1; i++) {
            if ([[currentPiString substringToIndex:i] isEqualToString:[goodPiString substringToIndex:i]]) {
                [string addAttribute:NSForegroundColorAttributeName
                               value:[UIColor greenColor]
                               range:NSMakeRange(0, i)];
                [string addAttribute:NSForegroundColorAttributeName
                               value:[UIColor redColor]
                               range:NSMakeRange(i, length - i)];
            }
        }
        
        self.piLabel.attributedText = string;
        self.nLabel.text = [NSString stringWithFormat:@"Iteration: %@", @(self.n)];
    }
    
    [self performSelector:@selector(visualize) withObject:nil afterDelay:0.04];
}

@end
