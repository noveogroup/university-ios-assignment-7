#import "PIWallesFormulaCalculator.h"

static NSInteger nStep = 2000000;

@interface PIWallesFormulaCalculator ()

@property (nonatomic, assign) BOOL working;
@property (nonatomic, assign) BOOL paused;

@property (atomic, assign) BOOL firstQueueIsFree;
@property (atomic, assign) BOOL secondQueueIsFree;
@property (atomic, assign) BOOL thirdQueueIsFree;
@property (atomic, assign) BOOL fourthQueueIsFree;

@property (nonatomic, assign) NSInteger workedThreads;

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

#pragma mark - comands

- (void) start
{
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
    dispatch_queue_t queue1 = dispatch_queue_create("first", NULL);
    dispatch_queue_t queue2 = dispatch_queue_create("second", NULL);
    dispatch_queue_t queue3 = dispatch_queue_create("third", NULL);
    dispatch_queue_t queue4 = dispatch_queue_create("fourth", NULL);
    
    self.firstQueueIsFree = YES;
    self.secondQueueIsFree = YES;
    self.thirdQueueIsFree = YES;
    self.fourthQueueIsFree = YES;
    
    
    void (^calculusBlock)(void) = ^(){
        long double baseN = self.n;
        self.n += nStep;
        
        long double startPi = 1;
        for (long double n = baseN; n < baseN + nStep; n++) {
            startPi *= 2 * n * 2 * n / ( 2 * n - 1) / ( 2 * n + 1);
        }
        self.pi *= startPi;
        
        const char* charsString = dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL);
        NSString* string = [[NSString alloc] initWithCString:charsString encoding:NSASCIIStringEncoding];;
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
