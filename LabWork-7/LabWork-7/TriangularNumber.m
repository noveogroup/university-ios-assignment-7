#import "TriangularNumber.h"


@implementation TriangularNumber

- (instancetype)init {
    self = [super init];
    if (self != nil) {
        _value = 0;
        _positionInSequence = 0;
    }
    return self;
}

- (long long)calculateNextValue {
    self.positionInSequence++;
    self.value = self.value + self.positionInSequence;
    return self.value;
}

@end
