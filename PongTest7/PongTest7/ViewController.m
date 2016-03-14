#import "ViewController.h"
#import <CoreGraphics/CoreGraphics.h>

@interface ViewController ()

@end

@implementation ViewController

-(void)Collision{//столкновение //у меня будет первая и вторая ракетка
    
    //если удар о ракетку 1
    if (CGRectIntersectsRect(Ball.frame, Player1.frame)) {//квадрат пересекает квадрат
        
        Y = arc4random() %5;//
        Y = 0-Y;
    }
    
    //если удар о ракетку 2
    if (CGRectIntersectsRect(Ball.frame, Player2.frame)) {
        
        Y = arc4random() %5;
       // Y = 0-Y;
    }
}

-(void)PlayerOneMovement {// снизу
    
    if (Player1.center.x > Ball.center.x) {
        Player1.center = CGPointMake(Player1.center.x -2, Player1.center.y);
    }
    
    if (Player1.center.x < Ball.center.x){
        Player1.center = CGPointMake(Player1.center.x + 2, Player1.center.y);
    }
    
    if (Player1.center.x < 50) {
        Player1.center = CGPointMake(50, Player1.center.y);
    }
    
    if (Player1.center.x > 246) {
       Player1.center = CGPointMake(246, Player1.center.y);
    
    }
   
}

-(void)PlayerSecondMovement { //вверху
    
    
    if (Player2.center.x > Ball.center.x) {
        Player2.center = CGPointMake(Player2.center.x -2, Player2.center.y);
    }
    
    if (Player2.center.x < Ball.center.x){
        Player2.center = CGPointMake(Player2.center.x + 2, Player2.center.y);
    }
    
    if (Player2.center.y > 200) {
        Player2.center = CGPointMake(Player2.center.x, 200);
    }
    
    if (Player2.center.y < 200) {
        Player2.center = CGPointMake(Player2.center.x, 200);
    }
    
}


-(IBAction)StartButton:(id)sender{//видимо движение шарика он начинает двигаться когда нажата и спрятана кнопка старта
    
    start.hidden = YES;//кнопка старта прячется
    
    Y = arc4random() % 11;//рандомное движение шарика
    Y = Y - 5;
    
    X = arc4random() % 11;
    X = X - 5;
    
    if (Y == 0){
        Y = 1;
    }
    
    if (X == 0){
        X = 1;
    }
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(BallMovement) userInfo:nil repeats:YES]; //таймер который движет шарик
    
}

-(void)BallMovement{
    
    [self PlayerOneMovement];
    [self PlayerSecondMovement];
    [self Collision];
    
    // определяет движение шарика
    
    Ball.center = CGPointMake(Ball.center.x + X, Ball.center.y + Y);
   
    
    if (Ball.center.x < 50) {
        X = 0 - X;
    }
    
    if (Ball.center.x > 305) {
        X = 0 - X;
    }
    
    if (Ball.center.y < 0) {//вышел за верхнюю границу
      
        Ball.center = CGPointMake(145, 256);
        
    }
    
    if (Ball.center.y > 560) {//вышел за нижнюю границу
      
      Ball.center = CGPointMake(145, 256);
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
        [self BallMovement];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

@end
