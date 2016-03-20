#import "PIWallesFormulaCalculator.h"

static NSInteger nStep = 2000000;
static NSInteger queuesCount = 4;

@interface PIWallesFormulaCalculator ()

@property (nonatomic, assign) BOOL working;
@property (nonatomic, assign) BOOL paused;

@property (atomic, strong) NSLock *lockN;
@property (atomic, strong) NSLock *lockPi;

@property (atomic) NSInteger n;
@property (atomic) Float64 pi;

@end

@implementation PIWallesFormulaCalculator

+(PIWallesFormulaCalculator *) sharedCalculator
{
    static PIWallesFormulaCalculator* calculator = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        calculator = [[PIWallesFormulaCalculator alloc] init];
    });
    
    return calculator;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _lockN = [NSLock new];
        _lockPi = [NSLock new];
    }
    return self;
}

#pragma mark - comands

- (void) start
{
    self.pi = 2;
    self.n = 1;
    self.working = YES;
    self.paused = NO;

    [self runCalculus];
}

- (void) pause
{
    self.paused = !self.paused;
}

- (void) stop
{
    self.paused = NO;
    self.working = NO;
}


- (void) runCalculus
{
    NSMutableArray *queues = [NSMutableArray array];
    NSMutableArray *queuesIsFree = [NSMutableArray array];
    NSMutableArray *queuesNames = [NSMutableArray array];
    
    for (int i = 0; i < queuesCount; i++) {
        NSString *queueName = [@(i) stringValue];
        
        [queuesNames addObject:queueName];
        [queues addObject:dispatch_queue_create(queueName.UTF8String, NULL)];
        [queuesIsFree addObject:@(YES)];
    }
    
    void (^calculusBlock)(void) = ^(){
        Float64 baseN = (Float64)self.n;
        
        [self.lockN lock];
        self.n += nStep;
        [self.lockN unlock];

        Float64 startPi = 1;
        for (Float64 n = baseN; n < baseN + nStep; n++) {
            startPi *= 2 * n * 2 * n / ( 2 * n - 1) / ( 2 * n + 1);
        }
        [self.lockPi lock];
        self.pi = self.pi * startPi;
        [self.lockPi unlock];

        
        const char *charsString = dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL);
        NSString *string = [[NSString alloc] initWithCString:charsString encoding:NSUTF8StringEncoding];;
        
        NSInteger index = [queuesNames indexOfObject:string];
        @synchronized (queuesIsFree) {
            queuesIsFree[index] = @(YES);
        }

    };
    
    NSInteger oldN = self.n + 1;
    while (self.working) {
        if (!self.paused && (oldN != self.n)) {
            @synchronized (queuesIsFree) {
                NSUInteger freeQueueIndex = [queuesIsFree indexOfObject:@(YES)];
                if (freeQueueIndex != NSNotFound) {
                    oldN = self.n;
                    queuesIsFree[freeQueueIndex] = @(NO);
                    dispatch_async(queues[freeQueueIndex], calculusBlock);
                }
            }
        }
    }
}

@end
