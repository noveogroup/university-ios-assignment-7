#import "UIColor+RandomColor.h"

@implementation UIColor (RandomColor)
+ (instancetype)randomColor
{
    float red = (arc4random() % 255) / 100.f;
    float green = (arc4random() % 255) / 100.f;
    float blue = (arc4random() % 255) / 100.f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.f];
}




@end
