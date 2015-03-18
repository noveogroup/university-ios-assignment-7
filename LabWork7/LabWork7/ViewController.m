

#import "ViewController.h"

@interface ViewController ()


@property (strong, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    __typeof(self) __weak wself = self;
    dispatch_queue_t queue =
        dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        unsigned long long a = 2;
        unsigned long long b = 1;
        unsigned long long c = 3;
        while(YES)
        {
            a = b;
            b = c;
            c = a + b;
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                wself.label.text = [NSString stringWithFormat:@"Lucas numbers: %llu", c];
            });
        }
        
    });

}



@end
