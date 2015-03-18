
#import "PrimeNumberService.h"

@interface PrimeNumberService()
@property (atomic, strong) NSMutableArray *primeNumberArray;
@end

@implementation PrimeNumberService

-(id) init{
    self = [super init];
    if (self)
        self.primeNumberArray = [NSMutableArray array];
    
    return self;
}

-(void) start{
    
    for (NSInteger i = 2 ; i < 100 ; i++){
        
        if ([self isPrimeNumber:i])
            [self.primeNumberArray addObject:[NSString stringWithFormat:@"%d",i]];
        
        sleep(1);
    }
}

-(Boolean) isPrimeNumber:(NSInteger) number{
    
    for (NSInteger i= 2; i < number; i++){
        if (number % i == 0)
            return false;
    }
    return true;
}

-(NSArray*) primeNumbers{
    return [NSArray arrayWithArray:self.primeNumberArray];
}

@end
