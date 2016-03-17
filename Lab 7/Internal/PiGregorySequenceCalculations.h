#import <Foundation/Foundation.h>

@interface PiGregorySequenceCalculations : NSObject

@property (atomic, assign) NSInteger n;
@property (atomic, assign) long double pi;

@property (nonatomic, readonly) BOOL working;

+(PiGregorySequenceCalculations *) sharedCalculator;

- (void) start;
- (void) pause;
- (void) stop;

@end
