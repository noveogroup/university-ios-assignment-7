
#import "ViewController.h"

#import "GameViewController.h"

#import "PiGregorySequenceCalculations.h"
#import "PIWallesFormulaCalculator.h"

static long double const goodPi = 3.141592653589793238462643383279;

@interface ViewController ()

@property (nonatomic, strong) NSThread *thread;

@property (nonatomic, assign) BOOL working;
@property (nonatomic, assign) BOOL pause;

@property (nonatomic, strong) PiGregorySequenceCalculations *piGSCalculator;
@property (nonatomic, strong) PIWallesFormulaCalculator *piWFCalculator;

@property (nonatomic, weak) IBOutlet UILabel *piLabel;
@property (nonatomic, weak) IBOutlet UILabel *nLabel;

@property (nonatomic, weak) IBOutlet UISegmentedControl *calculatorType;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.piGSCalculator = [PiGregorySequenceCalculations sharedCalculator];
    self.piWFCalculator = [PIWallesFormulaCalculator sharedCalculator];
    
    [self startCalculation];
    [self startVisualization];
}

#pragma mark - Actions

- (IBAction)pauseAction
{
    self.pause = !self.pause;
    [self.piGSCalculator pause];
    [self.piWFCalculator pause];
}

- (IBAction)startAgainAction
{
    [self stopAllCalculations];
    [self startCalculation];
}

- (IBAction)gameAction
{
    [self stopAllCalculations];
}

- (IBAction)changeCalculatorType
{
    [self startAgainAction];
}



#pragma mark - calculation

- (void) stopAllCalculations
{
    [self.piGSCalculator stop];
    [self.piWFCalculator stop];
}

- (void) startCalculation
{
    if (self.thread) {
        [self.thread cancel];
    }
    self.thread = [[NSThread alloc] initWithTarget:self selector:@selector(calculate) object:nil];

    self.working = YES;
    self.pause = NO;

    [self.thread start];
}

- (void) calculate
{
    switch (self.calculatorType.selectedSegmentIndex) {
        case 0:
            self.piGSCalculator.pi = 0;
            self.piGSCalculator.n = 0;
            [self.piGSCalculator start];
            break;
            
        case 1:
            self.piWFCalculator.pi = 2;
            self.piWFCalculator.n = 1;
            [self.piWFCalculator start];
            break;
            
        default:
            break;
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
        
        double doublePi;
        NSInteger n;
        
        switch (self.calculatorType.selectedSegmentIndex) {
            case 0:
                doublePi = (double)self.piGSCalculator.pi;
                n = self.piGSCalculator.n;
                break;
                
            case 1:
                doublePi = (double)self.piWFCalculator.pi;
                n = self.piWFCalculator.n;
                break;
                
            default:
                doublePi = 3.14;
                n = 0;
                break;
        }
        
        NSString* currentPiString = [@(doublePi) stringValue];
        NSString* goodPiString = [@((double)goodPi) stringValue];
        
        NSMutableAttributedString* string = [[NSMutableAttributedString alloc] initWithString:currentPiString];
        NSInteger length = MIN([currentPiString length], [goodPiString length]) ;

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
        self.nLabel.text = [NSString stringWithFormat:@"Iteration: %@", @(n)];
    }
    
    [self performSelector:@selector(visualize) withObject:nil afterDelay:0.04];
}

@end
