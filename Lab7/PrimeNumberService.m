
#import "PrimeNumberService.h"

@interface PrimeNumberService()
@property (nonatomic, strong) NSMutableArray *primeNumberArray;
@property (nonatomic, strong) dispatch_queue_t concurrentPrimeNumberQueue;
@end

@implementation PrimeNumberService

@synthesize primeNumberArray = primeNumberArray_;
@synthesize concurrentPrimeNumberQueue = concurrentPrimeNumberQueue_;

-(id) init{
    self = [super init];
    if (self)
    {
        primeNumberArray_ = [NSMutableArray array];
        concurrentPrimeNumberQueue_ = dispatch_queue_create("com.noveogroup", DISPATCH_QUEUE_CONCURRENT);
    }
    
    return self;
}

-(void) start{
    
    __typeof(NSMutableArray) __weak *primeNumberArrayWeak= self.primeNumberArray;
    
    for (NSInteger i = 2 ; i < 100 ; i++){
        
        if ([self isPrimeNumber:i]){
            dispatch_barrier_async(self.concurrentPrimeNumberQueue, ^{
                [primeNumberArrayWeak addObject:[NSString stringWithFormat:@"%d",i]];
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
