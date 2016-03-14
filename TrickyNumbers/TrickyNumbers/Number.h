#import <Foundation/Foundation.h>

@interface Number : NSObject
@property (assign, nonatomic) unsigned long long value;
@property (assign, nonatomic) NSUInteger count;

- (long long)calculateValue;
@end
