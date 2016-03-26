#import <Foundation/Foundation.h>

@interface PIWallesFormulaCalculator : NSObject

@property (nonatomic, readonly) NSInteger n;
@property (nonatomic, readonly) Float64 pi;

+(PIWallesFormulaCalculator *) sharedCalculator;

- (void) start;
- (void) pause;
- (void) stop;

@end
