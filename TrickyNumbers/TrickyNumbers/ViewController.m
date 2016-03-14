#import "ViewController.h"
#import "Number.h"
#import "UIColor+RandomColor.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) Number *number;

- (IBAction)actionButton:(UIButton *)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.number = [[Number alloc] init];
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self
                                                      selector:@selector(updateLabelText)];
    
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
    NSThread *calculatingThread = [[NSThread alloc] initWithTarget:self
                                                          selector:@selector(calculating)
                                                            object:nil];
    
    [calculatingThread start];
    
    
    
}

#pragma mark - Methods
- (void)updateLabelText
{
    self.label.text = [NSString stringWithFormat:@"%ld : %llu",
                       (unsigned long)self.number.count,
                       self.number.value];
}


- (void)calculating
{
    while (YES) {
        [self.number calculateValue];
    }
}

- (UIColor *)randomColor
{
    float red = (arc4random() % 255) / 100.f;
    float green = (arc4random() % 255) / 100.f;
    float blue = (arc4random() % 255) / 100.f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.f];
}

#pragma mark - Actions

- (IBAction)actionButton:(UIButton *)sender {
    self.view.backgroundColor = [UIColor randomColor];
}
@end
