
#import "GameViewController.h"

static CGFloat batWidth = 50.0f;
static CGFloat batHeight = 10.0f;

static CGFloat ballRadius = 10.0f;

static CGFloat offset = 30.0f;

@interface GameViewController ()

@property (nonatomic, strong) UIView* ball;
@property (nonatomic, strong) UIView* topBat;
@property (nonatomic, strong) UIView* bottomBat;

@property (nonatomic, strong) NSThread* calculationThread;

@property (atomic, assign) Velocity ballVelocity;
@property (atomic, assign) Velocity topBatVelocity;
@property (atomic, assign) Velocity bottomBatVelocity;

@property (atomic, assign) CGFloat nextStepTime;
@property (atomic, assign) CGFloat tableWidth;
@property (atomic, assign) CGFloat tableHeight;

@property (atomic, assign) BOOL animateNextStep;

@property (atomic, assign) BOOL working;

@end

@implementation GameViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    [self setupViews];
    
    self.navigationController.navigationBar.hidden = YES;
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.working = NO;
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.working = YES;
    [self startMoving];
    [self startAnimating];
}


- (void)setupViews
{
    self.tableWidth = CGRectGetWidth(self.view.bounds);
    self.tableHeight = CGRectGetHeight(self.view.bounds);
    
    self.ball = [[UIView alloc] initWithFrame:CGRectMake((self.tableWidth - 2*ballRadius)/2, (self.tableHeight - 2*ballRadius)/2, 2*ballRadius, 2*ballRadius)];
    self.ball.layer.cornerRadius = ballRadius;
    self.ball.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.ball];
    
    self.topBat = [[UIView alloc] initWithFrame:CGRectMake((self.tableWidth - batWidth)/2, offset, batWidth, batHeight)];
    self.topBat.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.topBat];
    
    self.bottomBat = [[UIView alloc] initWithFrame:CGRectMake((self.tableWidth - batWidth)/2, self.tableHeight - batHeight - offset, batWidth, batHeight)];
    self.bottomBat.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bottomBat];
    
    self.view.backgroundColor = [UIColor greenColor];
}

- (void) startMoving
{
    self.calculationThread = [[NSThread alloc] initWithTarget:self selector:@selector(calculate) object:nil];
    self.ballVelocity = (Velocity){50,300};
    self.topBatVelocity = (Velocity){0,0};
    self.bottomBatVelocity = (Velocity){0,0};
    self.nextStepTime = 0;
    
    [self.calculationThread start];
}


- (void) calculate
{
    while (self.working) {
        if (!self.animateNextStep) {
            
            float currentBallX = self.ball.frame.origin.x + ballRadius;
            float currentBallY = self.ball.frame.origin.y + ballRadius;
            
            
            if ( (currentBallX - ballRadius) <= 1.0f && (currentBallX - ballRadius) >= -1.0f) {
                
                self.ballVelocity = (Velocity){-self.ballVelocity.x, self.ballVelocity.y};
                
            } else if ( (self.tableWidth - currentBallX - ballRadius) <= 1.0f && (self.tableWidth - currentBallX - ballRadius) >= -1.0f){
                
                self.ballVelocity = (Velocity){-self.ballVelocity.x, self.ballVelocity.y};
            }
            
            
            if ( (currentBallY - batHeight - ballRadius - offset) <= 1.0f && (currentBallY - batHeight - ballRadius - offset) >= -1.0f) {
                
                //friction
                float friction;
                if (self.topBatVelocity.x < 0 && self.ballVelocity.x < 0) {
                    friction = - (self.topBatVelocity.x - self.ballVelocity.x)*0.5;
                } else {
                    friction = (self.topBatVelocity.x - self.ballVelocity.x)*0.5;
                }
                
                self.ballVelocity = (Velocity){self.ballVelocity.x + friction, -self.ballVelocity.y};
                
            } else if ( (self.tableHeight - currentBallY - batHeight - ballRadius - offset) <=1.0f && (self.tableHeight - currentBallY - batHeight - ballRadius - offset) >= -1.0f){
                
                //friction
                float friction;
                if (self.topBatVelocity.x < 0 && self.ballVelocity.x < 0) {
                    friction = - (self.bottomBatVelocity.x - self.ballVelocity.x)*0.5;
                } else {
                    friction = (self.bottomBatVelocity.x - self.ballVelocity.x)*0.5;
                }
                self.ballVelocity = (Velocity){self.ballVelocity.x + friction, -self.ballVelocity.y};
    
            }
            
            
            if (self.ballVelocity.y > 0) {
                //bottom bat will move
                
                float timeToMeatingWithBat = (self.tableHeight - currentBallY - ballRadius - batHeight - offset) / self.ballVelocity.y;
                
                float timeToMeatingWithWall;
                if (self.ballVelocity.x > 0) {
                    timeToMeatingWithWall = (self.tableWidth - currentBallX - ballRadius) / self.ballVelocity.x;
                } else {
                    timeToMeatingWithWall = - (currentBallX - ballRadius) / self.ballVelocity.x;
                }
                
                
                if (timeToMeatingWithBat && timeToMeatingWithWall) {
                    if (timeToMeatingWithBat <= timeToMeatingWithWall) {
                        
                        float apprMeatingPosition = currentBallX + timeToMeatingWithBat * self.ballVelocity.x;
                        
                        float batXVelocity = (apprMeatingPosition - self.bottomBat.center.x) / timeToMeatingWithBat;
                        self.bottomBatVelocity = (Velocity){batXVelocity, 0};
                        
                        self.topBatVelocity = (Velocity){0, 0};
                        
                        self.nextStepTime = timeToMeatingWithBat;
                    } else {
                        
                        float batXVelocity = (self.tableWidth / 2 - self.bottomBat.center.x) / timeToMeatingWithWall;
                        self.bottomBatVelocity = (Velocity){batXVelocity, 0};
                        
                        self.topBatVelocity = (Velocity){0, 0};
                        
                        self.nextStepTime = timeToMeatingWithWall;
                    }
                } else {
                    self.topBatVelocity = (Velocity){0, 0};
                    self.bottomBatVelocity = (Velocity){0, 0};
                }
                
                
            }
            else if (self.ballVelocity.y < 0){
                //top bat will move
                
                float timeToMeatingWithBat = - (currentBallY - ballRadius - batHeight - offset) / self.ballVelocity.y;
                
                float timeToMeatingWithWall;
                if (self.ballVelocity.x > 0) {
                    timeToMeatingWithWall = (self.tableWidth - currentBallX - ballRadius) / self.ballVelocity.x;
                } else {
                    timeToMeatingWithWall = - (currentBallX -  ballRadius) / self.ballVelocity.x;
                }
                
                
                if (timeToMeatingWithBat && timeToMeatingWithWall) {
                    if (timeToMeatingWithBat <= timeToMeatingWithWall) {
                        
                        float apprMeatingPosition = currentBallX + timeToMeatingWithBat * self.ballVelocity.x;
                        
                        float batXVelocity = (apprMeatingPosition - self.topBat.center.x) / timeToMeatingWithBat;
                        self.topBatVelocity = (Velocity){batXVelocity, 0};
                        
                        self.bottomBatVelocity = (Velocity){0, 0};
                        
                        self.nextStepTime = timeToMeatingWithBat;
                    } else {
                        
                        float batXVelocity = (self.tableWidth / 2 - self.topBat.center.x) / timeToMeatingWithWall;
                        self.topBatVelocity = (Velocity){batXVelocity, 0};
                        
                        self.bottomBatVelocity = (Velocity){0, 0};
                        
                        self.nextStepTime = timeToMeatingWithWall;
                    }
                } else {
                    self.topBatVelocity = (Velocity){0, 0};
                    self.bottomBatVelocity = (Velocity){0, 0};
                }
                
                
            }
            self.animateNextStep = YES;
        }
    
    }
}

- (void) startAnimating
{
    [self performSelector:@selector(visualize) withObject:nil afterDelay:0.5f];
}

- (void) visualize
{
    while (!self.animateNextStep) {
        //sleep
    }
    
    [UIView animateWithDuration:self.nextStepTime delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        
        CGRect currentFrame = self.ball.frame;
        
        self.ball.frame = CGRectMake(currentFrame.origin.x + self.ballVelocity.x * self.nextStepTime, currentFrame.origin.y + self.ballVelocity.y * self.nextStepTime, currentFrame.size.width, currentFrame.size.height);
        
        self.topBat.center = (CGPoint){self.topBat.center.x + self.topBatVelocity.x * self.nextStepTime, self.topBat.center.y + self.topBatVelocity.y * self.nextStepTime};
        self.bottomBat.center = (CGPoint){self.bottomBat.center.x + self.bottomBatVelocity.x * self.nextStepTime, self.bottomBat.center.y + self.bottomBatVelocity.y * self.nextStepTime};
        
    } completion:^(BOOL finished) {
        [self performSelector:@selector(visualize) withObject:nil afterDelay:0.0f];
    }];
    
    self.animateNextStep = NO;
}

@end
