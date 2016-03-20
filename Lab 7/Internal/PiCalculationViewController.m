
#import "PiCalculationViewController.h"

#import "GameViewController.h"

#import "PiGregorySequenceCalculations.h"
#import "PIWallesFormulaCalculator.h"

@interface PiCalculationViewController ()

@property (nonatomic, strong) NSThread *thread;

@property (nonatomic, assign) BOOL working;
@property (nonatomic, assign) BOOL pause;

@property (nonatomic, strong) PiGregorySequenceCalculations *piGSCalculator;
@property (nonatomic, strong) PIWallesFormulaCalculator *piWFCalculator;

@property (nonatomic, weak) IBOutlet UILabel *piLabel;
@property (nonatomic, weak) IBOutlet UILabel *nLabel;

@property (nonatomic, weak) IBOutlet UISegmentedControl *calculatorType;


@end

@implementation PiCalculationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.piGSCalculator = [PiGregorySequenceCalculations sharedCalculator];
    self.piWFCalculator = [PIWallesFormulaCalculator sharedCalculator];
    
    [self startCalculation];
    [self startVisualization];
}

#pragma mark - Actions

- (IBAction)pauseAction:(UIButton *)sender
{
    self.pause = !self.pause;
    if (self.pause) {
        [sender setTitle:@"Resume" forState:UIControlStateNormal];
    } else {
        [sender setTitle:@"Pause" forState:UIControlStateNormal];
    }
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
            [self.piGSCalculator start];
            break;
            
        case 1:
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
        
        Float64 doublePi;
        NSInteger n;
        
        switch (self.calculatorType.selectedSegmentIndex) {
            case 0:
                doublePi = self.piGSCalculator.pi;
                n = self.piGSCalculator.n;
                break;
                
            case 1:
                doublePi = self.piWFCalculator.pi;
                n = self.piWFCalculator.n;
                break;
                
            default:
                doublePi = 3.14;
                n = 0;
                break;
        }
        
        NSString* currentPiString = [NSString stringWithFormat:@"%0.15f", doublePi];
        NSString* goodPiString = [NSString stringWithFormat:@"%0.15f", M_PI];
        
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
