
#import "PrimeNumberService.h"

@interface PrimeNumberService()
@property (nonatomic, strong) NSMutableArray *primeNumberArray;
@end

@implementation PrimeNumberService

@synthesize primeNumberArray = primeNumberArray_;

-(id) init{
    self = [super init];
    if (self)
        primeNumberArray_ = [NSMutableArray array];
    
    return self;
}

-(void) start{
    
    for (NSInteger i = 2 ; i < 100 ; i++){
        
        if ([self isPrimeNumber:i]){
            dispatch_barrier_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [self.primeNumberArray addObject:[NSString stringWithFormat:@"%d",i]];
            });
        }

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
    return [self.primeNumberArray copy];
}

@end
