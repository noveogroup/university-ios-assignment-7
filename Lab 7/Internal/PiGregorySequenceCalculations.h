#import <Foundation/Foundation.h>

@interface PiGregorySequenceCalculations : NSObject

@property (nonatomic, assign, readonly) NSInteger n;
@property (nonatomic, assign, readonly) Float64 pi;

+(PiGregorySequenceCalculations *) sharedCalculator;
- (instancetype)init;

- (void) start;
- (void) pause;
- (void) stop;

@end
