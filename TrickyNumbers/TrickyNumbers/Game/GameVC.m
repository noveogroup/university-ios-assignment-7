#import "GameVC.h"
#import "UIColor+RandomColor.h"

typedef enum : NSUInteger {
    Up,
    Down,
} BallDirection;

@interface GameVC ()
@property (strong, nonatomic) IBOutlet UIView *field;
@property (nonatomic) BallDirection currentDirection;
@property (nonatomic) CGPoint currentBallCoord;
@property (nonatomic) CGPoint newBallCoord;

@property (strong, nonatomic) UIView *ball;

@property (strong, nonatomic) UIView *platformTop;
@property (strong, nonatomic) UIView *platformBottom;

- (IBAction)actionStart:(UIButton *)sender;
- (IBAction)actionChangeColor:(UIButton *)sender;
@end


@implementation GameVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.currentDirection = Down;

}

- (void)setupField
{

    self.field.frame = CGRectMake(0,
                                  0,
                                  CGRectGetWidth(self.view.frame),
                                  CGRectGetHeight(self.view.frame));
    
    self.field.center = CGPointMake(CGRectGetMidX(self.view.frame),
                                    CGRectGetMidY(self.view.frame));
    
}

- (void)setupBall
{
    self.ball = [[UIView alloc] init];
    self.ball.frame = CGRectMake(CGRectGetMidX(self.field.frame),
                                 CGRectGetMidY(self.field.frame),
                                 20,
                                 20);
    
    self.currentBallCoord = self.ball.center;
    self.ball.layer.cornerRadius = 10;
    self.ball.backgroundColor = [UIColor blackColor];
    [self.field addSubview:self.ball];
}

- (void)setupPlatform
{
    self.platformTop = [[UIView alloc] init];
    self.platformTop.frame = CGRectMake(CGRectGetMidX(self.field.bounds) - 50,
                                        CGRectGetMinY(self.field.bounds) - 10,
                                        100,
                                        20);
    
    self.platformTop.layer.cornerRadius = 3;
    self.platformTop.backgroundColor = [UIColor yellowColor];
    [self.field addSubview:self.platformTop];

    
    self.platformBottom = [[UIView alloc] init];
    self.platformBottom.frame = CGRectMake(CGRectGetMidX(self.field.bounds) - 50,
                                           CGRectGetMaxY(self.field.bounds) - 10,
                                           100,
                                           20);
    self.platformBottom.layer.cornerRadius = 3;
    self.platformBottom.backgroundColor = [UIColor greenColor];
    
    [self.field addSubview:self.platformBottom];
    

}

- (void)gameStep
{
    self.currentBallCoord = self.ball.center;
    self.newBallCoord = [self nextCoordFromCoord:self.currentBallCoord];
}

- (CGPoint)nextCoordFromCoord:(CGPoint)coord
{
    CGFloat const min = CGRectGetMinY(self.field.bounds);
    CGFloat const max = CGRectGetMaxY(self.field.bounds);
    
    if (self.currentDirection == Down) {
        self.currentDirection = Up;
        CGFloat x = (CGFloat)(arc4random() % (int)max);
        CGFloat y = max;
        return CGPointMake(x, y);
        
    } else {
        self.currentDirection = Down;
        CGFloat x = (CGFloat)(arc4random() % (int)max);
        CGFloat y = min;
        return CGPointMake(x, y);
    }
}

- (void)startGame
{
    NSThread *gameLogic = [[NSThread alloc] initWithTarget:self
                                                  selector:@selector(engineLoop) object:nil];
    [gameLogic start];
}

- (void)engineLoop
{
    while (YES) {
        //usleep(1000);
        [self gameStep];
    }
}

- (void)printField
{
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
    
        self.ball.center = self.newBallCoord;
        
        if (self.currentDirection == Down) {
            self.platformTop.center = CGPointMake(self.newBallCoord.x,
                                                  CGRectGetMinY(self.field.bounds));
        } else {
            self.platformBottom.center = CGPointMake(self.newBallCoord.x,
                                                     CGRectGetMaxY(self.field.bounds));;
        }
        
        
    } completion:nil];
}


- (void)startUIRefresh
{
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self
                                                      selector:@selector(printField)];
    
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (IBAction)actionStart:(UIButton *)sender {
    [self setupBall];
    [self setupPlatform];
    [self startGame];
    [self startUIRefresh];
}

- (IBAction)actionChangeColor:(UIButton *)sender {
    self.view.backgroundColor = [UIColor randomColor];
}
@end
