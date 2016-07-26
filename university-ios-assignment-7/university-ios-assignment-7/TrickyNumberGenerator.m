#import "TrickyNumberGenerator.h"


@implementation TrickyNumberGenerator

+ (NSInteger)fibonacci:(NSInteger )n
{
    return n <= 2 ? 1 : [self fibonacci:(n-1)] + [self fibonacci:(n-2)];
}

@end
