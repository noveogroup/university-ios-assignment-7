#import "ViewController.h"
#import "Counter.h"

@interface ViewController ()

@property (nonatomic, strong) IBOutlet UILabel *label;

@property Counter *counter;

@end

@implementation ViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    if (self) {
       _counter = [[Counter alloc] init];
    }

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [[[NSThread alloc]
            initWithTarget:self.counter selector:@selector(count:) object:nil] start];

    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];

    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)update
{
    NSInteger number = self.counter.currentNumber;

    self.label.text = [NSString stringWithFormat:@"Prime number: %d", number];
}

@end
