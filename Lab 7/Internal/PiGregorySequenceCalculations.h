#import <Foundation/Foundation.h>

@interface PiGregorySequenceCalculations : NSObject

@property (atomic, readonly) NSInteger n;
@property (atomic, readonly) Float64 pi;

+(PiGregorySequenceCalculations *) sharedCalculator;
- (instancetype)init;

- (void) start;
- (void) pause;
- (void) stop;

@end
