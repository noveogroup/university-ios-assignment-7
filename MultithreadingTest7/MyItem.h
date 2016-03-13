#import <Foundation/Foundation.h>

@interface MyItem : NSObject


@property(copy, nonatomic) NSString *Number;

+(id)randomItem;

-(id)initWithRNumber:(NSString*)sNumber;

@end
