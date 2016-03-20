#import <Foundation/Foundation.h>

@interface PIWallesFormulaCalculator : NSObject

@property (atomic, assign) NSInteger n;
@property (atomic, assign) long double pi;

+(PIWallesFormulaCalculator *) sharedCalculator;
- (instancetype)init;

- (void) start;
- (void) pause;
- (void) stop;

@end
