#import <Foundation/Foundation.h>

@interface PIWallesFormulaCalculator : NSObject

@property (nonatomic, assign, readonly) NSInteger n;
@property (nonatomic, assign, readonly) Float64 pi;

+(PIWallesFormulaCalculator *) sharedCalculator;
- (instancetype)init;

- (void) start;
- (void) pause;
- (void) stop;

@end
