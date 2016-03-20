
#import "PiGregorySequenceCalculations.h"

static NSInteger nStep = 500000;

@interface PiGregorySequenceCalculations ()

@property (nonatomic, assign) BOOL paused;

@property (atomic, assign) BOOL firstQueueIsFree;
@property (atomic, assign) BOOL secondQueueIsFree;
@property (atomic, assign) BOOL thirdQueueIsFree;
@property (atomic, assign) BOOL fourthQueueIsFree;

@property (atomic, strong) NSLock *lock;

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
        _lock = [NSLock new];;
    }
    return self;
}

#pragma mark - comands

- (void) start
{
    _working = YES;
    
    [self runCalculus];
}

- (void) pause
{
    self.paused = !self.paused;
}

- (void) stop
{
    _working = NO;
}


- (void) runCalculus
{
    dispatch_queue_t queue1 = dispatch_queue_create("first", NULL);
    dispatch_queue_t queue2 = dispatch_queue_create("second", NULL);
    dispatch_queue_t queue3 = dispatch_queue_create("third", NULL);
    dispatch_queue_t queue4 = dispatch_queue_create("fourth", NULL);
    
    self.firstQueueIsFree = YES;
    self.secondQueueIsFree = YES;
    self.thirdQueueIsFree = YES;
    self.fourthQueueIsFree = YES;

    
    void (^calculusBlock)(void) = ^(){
        double baseN = self.n;
        self.n += nStep;
        long double startPi = 0;
        for (int n = baseN; n < baseN + nStep; n++) {
            startPi += powl(-1.0, (long double)n) * 4 / ( 2 * n + 1);
        }
        [self.lock lock];
        self.pi += startPi;
        [self.lock unlock];
       
        const char *charsString = dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL);
        NSString *string = [[NSString alloc] initWithCString:charsString encoding:NSASCIIStringEncoding];;
        if ([string isEqualToString:@"first"]) {
            self.firstQueueIsFree = YES;
        }
        else if ([string isEqualToString:@"second"]) {
            self.secondQueueIsFree = YES;
        }
        else if ([string isEqualToString:@"third"]) {
            self.thirdQueueIsFree = YES;
        }
        else if ([string isEqualToString:@"fourth"]) {
            self.fourthQueueIsFree = YES;
        }
    };
    
    NSInteger oldN = self.n + 1;
    while (self.working) {
        if (!self.paused && (oldN != self.n)) {
            
            if (self.firstQueueIsFree) {
                self.firstQueueIsFree = NO;
                oldN = self.n;
                dispatch_async(queue1, calculusBlock);
            } else if (self.secondQueueIsFree) {
                self.secondQueueIsFree = NO;
                oldN = self.n;
                dispatch_async(queue2, calculusBlock);
            } else if (self.thirdQueueIsFree) {
                self.thirdQueueIsFree = NO;
                oldN = self.n;
                dispatch_async(queue3, calculusBlock);
            } else if (self.fourthQueueIsFree) {
                self.fourthQueueIsFree = NO;
                oldN = self.n;
                dispatch_async(queue4, calculusBlock);
            }
        }
    }
    
    
}



@end
