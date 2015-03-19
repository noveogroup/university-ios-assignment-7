

#import "ViewController.h"


@interface ViewController ()

@property (nonatomic, strong) UIView *topPlatform;
@property (nonatomic, strong) UIView *bottomPlatform;
@property (nonatomic, strong) UIView *ball;

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)gameChangeLayoutsWithBall:(NSValue *) ball topPlatform:(NSValue *) topPlatform bottomPlatform:(NSValue *) bottomPlatform
{
    
    
    [self.ball setFrame:[ball CGRectValue]];
    [self.topPlatform setFrame:[topPlatform CGRectValue]];
    [self.bottomPlatform setFrame:[bottomPlatform CGRectValue]];
    
}


@end
