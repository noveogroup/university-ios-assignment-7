#import "ViewController.h"
#import "TrickyNumberGenerator.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    self.textView.text = @"";
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    typeof(self) __weak wself = self;
    
    dispatch_async(queue, ^{
        
        NSInteger n = [wself.textField.text integerValue];
        for (int i = 1; i <= n; i++) {
            NSInteger result = [TrickyNumberGenerator fibonacci:i];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [wself.textView insertText:[NSString stringWithFormat:@"%ld(%d), ", (long)result, i]];
            });
        }
    
    });
    return YES;
}

@end
