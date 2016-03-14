
#import <UIKit/UIKit.h>

@class  MyItem;

@interface ViewController : UIViewController
{

   __weak IBOutlet UILabel *valueLabel;
    
}

@property(strong,nonatomic) MyItem *item;

- (IBAction)changeValueAction:(UIButton *)sender;

@end

