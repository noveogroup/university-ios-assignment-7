
#import "ViewController.h"
#import "MyItem.h"
#import "MyItemStore.h"

@interface ViewController ()

@end
@implementation ViewController
@synthesize item;



- (void)viewDidLoad {
    [super viewDidLoad];
    [self engineLoop];
    
   
}

- (IBAction)changeValueAction:(UIButton *)sender {
    MyItem *newItem = [[MyItemStore sharedStore]createItem];
    [valueLabel setText:[newItem Number]];
    
}

//- (void)startGame
//{
//    NSThread *gameLogic = [[NSThread alloc] initWithTarget:self
//                                                  selector:@selector(engineLoop) object:nil];
//    [gameLogic start];
//}


- (void)dispatchSomeRaindrops
{
    
     MyItem *newItem = [[MyItemStore sharedStore]createItem];
        [valueLabel setText:[newItem Number]];
    
}

- (void)engineLoop
{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(dispatchSomeRaindrops) userInfo:nil repeats:YES];
}

@end
