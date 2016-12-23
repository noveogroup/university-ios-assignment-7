#import <Foundation/Foundation.h>


@interface TriangularNumber : NSObject

@property (assign, nonatomic) unsigned long long value;
@property (assign, nonatomic) NSInteger positionInSequence;

/**
 * Generates and returns the next element of sequence of triangular numbers.
 * Additional information about triangular numbers you can find on http://oeis.org/A000217
 */
- (long long)calculateNextValue;

@end
