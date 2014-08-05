#import "Counter.h"


@implementation Counter

- (void)count:(NSObject *)parameter
{
    for (int i = 2; i > -1; i++)
    {
        BOOL flag = YES;

        for (int j = 2; j * j <= i; j++)
        {
            if (i % j == 0)
            {
                flag = NO;

                break;
            }
        }

        if (flag)
        {
            @synchronized (self) {
                self.currentNumber = i;
            }

            usleep(500000);
        }
    }
}

- (NSInteger)currentNumber
{
    NSInteger result;

    @synchronized (self) {
       result = _currentNumber;
    }

    return result;
}

@end