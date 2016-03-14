#import "Number.h"

@implementation Number

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.value = 0;
        self.count = 0;
    }
    return self;
}


- (long long)calculateValue
{
    self.count++;
    if (self.count == 1) {
        self.value = 1;
    }
    
    self.value = self.value * (self.count - 1) + self.value * (self.count - 2);
    return self.value;
}

@end
