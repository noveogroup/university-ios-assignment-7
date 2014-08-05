#import <Foundation/Foundation.h>


@interface Counter : NSObject

- (void)count:(NSObject *)parameter;
@property (nonatomic, assign) NSInteger currentNumber;

@end