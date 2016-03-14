#import <UIKit/UIKit.h>

int Y;
int X;

@interface ViewController : UIViewController
{
    
    IBOutlet UIImageView *Player1;
    IBOutlet UIImageView *Player2;
    IBOutlet UIImageView *Ball;
    IBOutlet UIButton *start;
    
    NSTimer *timer;//переменная таймера
}

-(IBAction)StartButton:(id)sender;//нажата кнопка о старте игры
-(void)BallMovement;//движение шарика
-(void)PlayerOneMovement;//движение рокетки компьютера
-(void)Collision;//столкновение


@end

