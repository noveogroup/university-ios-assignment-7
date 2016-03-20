
#import "PiGregorySequenceCalculations.h"

static NSInteger nStep = 500000;
static NSInteger queuesCount = 4;

@interface PiGregorySequenceCalculations ()

@property (nonatomic, assign) BOOL working;
@property (nonatomic, assign) BOOL paused;

@property (atomic, assign) BOOL firstQueueIsFree;
@property (atomic, assign) BOOL secondQueueIsFree;
@property (atomic, assign) BOOL thirdQueueIsFree;
@property (atomic, assign) BOOL fourthQueueIsFree;

@property (atomic, strong) NSMutableArray* queuesIsFree;
@property (atomic) dispatch_queue_t queuesIsFreeQueue;

@property (atomic, strong) NSLock *lock;

@property (atomic, assign) NSInteger localN;
@property (atomic, assign) Float64 localPi;

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
        _lock = [NSLock new];
        _queuesIsFreeQueue = dispatch_queue_create("com.mydomain.myapp.queuesIsFreeQueue", NULL);
        _queuesIsFree = [NSMutableArray arrayWithArray:@[@(YES),@(YES),@(YES),@(YES)]];
    }
    return self;
}

- (void)changeState:(BOOL)state forQueueWithIndex:(NSUInteger)index
{
    dispatch_async(self.queuesIsFreeQueue, ^{
        [self.queuesIsFree replaceObjectAtIndex:index withObject:@(state)];
    });
}

#pragma mark - geters
- (NSInteger) n
{
    return self.localN;
}

- (Float64) pi
{
    return self.localPi;
}

#pragma mark - comands

- (void) start
{
    self.localPi = 0;
    self.localN = 0;
    self.working = YES;
    
    [self runCalculus];
}

- (void) pause
{
    self.paused = !self.paused;
}

- (void) stop
{
    self.working = NO;
}


- (void) runCalculus
{
    
    dispatch_queue_t queues[4] = {dispatch_queue_create("1", NULL),
                                    dispatch_queue_create("2", NULL),
                                    dispatch_queue_create("3", NULL),
                                    dispatch_queue_create("4", NULL)};
    NSArray* queuesNames = @[@"1", @"2", @"3", @"4"];
    
    void (^calculusBlock)(void) = ^(){
        NSInteger baseN = self.localN;
        
        [self.lock lock];
        self.localN += nStep;
        [self.lock unlock];

        Float64 startPi = 0;
        for (double n = baseN; n < baseN + nStep; n++) {
            startPi += (Float64)pow(-1.0, n) * 4 / ( 2 * n + 1);
        }
        
        [self.lock lock];
        self.localPi += startPi;
        [self.lock unlock];
       
        const char *charsString = dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL);
        NSString *string = [[NSString alloc] initWithCString:charsString encoding:NSASCIIStringEncoding];;
        
        for (NSUInteger i = 0; i < queuesCount; i++) {
            if ([string isEqualToString:queuesNames[i]]) {
                [self changeState:YES forQueueWithIndex:i];
                break;
            }
        }
    };
    
    NSInteger oldN = self.localN + 1;
    while (self.working) {
        if (!self.paused && (oldN != self.localN)) {
            
            for (NSUInteger i = 0; i < queuesCount; i++) {
                if ([[self.queuesIsFree objectAtIndex:i] boolValue]) {
                    [self changeState:NO forQueueWithIndex:i];
                    oldN = self.localN;
                    dispatch_async(queues[i], calculusBlock);
                    break;
                }
            }
        }
    }
    
    
}



@end
