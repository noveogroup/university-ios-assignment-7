

#import "ViewController.h"


@interface ViewController ()

@property (nonatomic, strong) UIView *topPlatform;
@property (nonatomic, strong) UIView *bottomPlatform;
@property (nonatomic, strong) UIView *ball;

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.ball = [[UIView alloc]init];
    self.ball.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.ball];
    // Create a top Bot
    self.topPlatform = [[UIView alloc]init];
    self.topPlatform.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.topPlatform];
    // Create a bottom Bot
    self.bottomPlatform = [[UIView alloc]init];
    self.bottomPlatform.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.bottomPlatform];
    
    Game *newGame = [[Game alloc]init];
    CGSize gameAreaSize = {
        self.view.bounds.size.width,
        self.view.bounds.size.height
    };
    newGame.gameAreaSize = gameAreaSize;
    newGame.delegate = self;
    [newGame startGame];

}

- (void)gameChangeLayoutsWithBall:(NSValue *) ball topPlatform:(NSValue *) topPlatform bottomPlatform:(NSValue *) bottomPlatform
{
    
    
    [self.ball setFrame:[ball CGRectValue]];
    [self.topPlatform setFrame:[topPlatform CGRectValue]];
    [self.bottomPlatform setFrame:[bottomPlatform CGRectValue]];
    
}


@end
