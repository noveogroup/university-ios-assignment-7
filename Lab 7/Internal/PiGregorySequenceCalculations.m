
#import "PiGregorySequenceCalculations.h"

static NSInteger nStep = 500000;
static NSInteger const queuesCount = 4;

@interface PiGregorySequenceCalculations ()

@property (nonatomic, assign) BOOL working;
@property (nonatomic, assign) BOOL paused;

@property (atomic, assign) BOOL firstQueueIsFree;
@property (atomic, assign) BOOL secondQueueIsFree;
@property (atomic, assign) BOOL thirdQueueIsFree;
@property (atomic, assign) BOOL fourthQueueIsFree;

@property (atomic, strong) NSLock *lockN;
@property (atomic, strong) NSLock *lockPi;

@property (atomic) NSInteger n;
@property (atomic) Float64 pi;

@property (atomic) BOOL readyToRun;

@end

@implementation PiGregorySequenceCalculations

+(PiGregorySequenceCalculations *) sharedCalculator
{
    static PiGregorySequenceCalculations* calculator = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        calculator = [[PiGregorySequenceCalculations alloc] init];
    });
    
    return calculator;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _lockN = [NSLock new];
        _lockPi = [NSLock new];
        _readyToRun = YES;
    }
    return self;
}

#pragma mark - comands

- (void) start
{
    self.pi = 0;
    self.n = 0;
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
    self.working = NO;
    self.paused = NO;
    while (!self.readyToRun) {
        //wait
    }
}

- (void) runCalculus
{
    
    NSMutableArray *queues = [NSMutableArray array];
    NSMutableArray *queuesIsFree = [NSMutableArray array];
    NSMutableArray *queuesNames = [NSMutableArray array];
    
    for (int i = 0; i < queuesCount; i++) {
        NSString *queueName = [[NSString alloc] initWithFormat:@"%@", @(i)];
        
        [queuesNames addObject:queueName];
        
        dispatch_object_t queue = dispatch_queue_create(queueName.UTF8String, NULL);
        if (queue) {
            dispatch_set_context(queue, (__bridge void *)(queueName));
        }
        
        [queues addObject:queue];
        [queuesIsFree addObject:@(YES)];
    }
    
    void (^calculusBlock)(void) = ^(){
        NSInteger baseN = self.n;
        
        [self.lockN lock];
        self.n += nStep;
        [self.lockN unlock];

        Float64 startPi = 0;
        for (double n = baseN; n < baseN + nStep; n++) {
            startPi += (Float64)pow(-1.0, n) * 4 / ( 2 * n + 1);
        }
        
        [self.lockPi lock];
        self.pi += startPi;
        [self.lockPi unlock];
       
        const char *charsString = dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL);
        NSString *string = [[NSString alloc] initWithCString:charsString encoding:NSUTF8StringEncoding];;
        
        NSInteger index = [queuesNames indexOfObject:string];
        @synchronized (queuesIsFree) {
            queuesIsFree[index] = @(YES);
        }
    };
    
    self.readyToRun = NO;
    
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
    
    self.readyToRun = YES;
    NSLog(@"end");
    
}



@end
