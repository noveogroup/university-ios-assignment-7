
#import "PongEngine.h"

static CGPoint const ballOrigin = {100, 100};
static CGSize const ballSize = {20, 20};

static CGPoint const botOrigin = {20,40};
static CGSize const botSize = {120, 20};

static NSInteger const verticalTopAsset = 60;
static NSInteger const verticalBottomAsset = 20;
static NSInteger const horizontalAsset = 0;

typedef enum {
    directionNE = 0, // Up-Right
    directionSE = 1, // Down-Right
    directionSW = 2, // Down-Left
    directionNW = 3, // Up-Left
    directionDefault = directionNE
} Direction;

#pragma mark - PongData Extension

@interface PongData ()

- (void)setBallLayout:(NSValue/*with CGRect*/*)layout;
- (void)setTopBotLayout:(NSValue/*with CGRect*/*)layout;
- (void)setBottomBotLayout:(NSValue/*with CGRect*/*)layout;

@end


#pragma mark - PongEngine Extension

@interface PongEngine ()

@property (nonatomic, strong) PongData *currentData;
@property (nonatomic, readwrite) Direction ballMovingDirection;
@property (nonatomic, readwrite) BOOL topBotShouldMove;
@property (nonatomic, readwrite) BOOL bottomBotShouldMove;

- (void)calculateStartData;
- (void)calculateFrame;
- (void)calculateBallMoving;
- (NSValue/*With CGRect*/*)calculateBotMovingWithLayout:(NSValue/*With CGRect*/*)layout;

@end


#pragma mark - PongData Implementation

@implementation PongData

@synthesize ballLayout = ballLayout_;
@synthesize topBotLayout = topBotLayout_;
@synthesize bottomBotLayout = bottomBotLayout_;

#pragma mark Private Methods

- (void)setBallLayout:(NSValue/*with CGRect*/*)layout
{
    ballLayout_ = layout;
}

- (void)setTopBotLayout:(NSValue/*with CGRect*/*)layout
{
    topBotLayout_ = layout;
}

- (void)setBottomBotLayout:(NSValue/*with CGRect*/*)layout
{
    bottomBotLayout_ = layout;
}

#pragma mark NSCopying Protocol Methods

- (id)copyWithZone:(NSZone *)zone
{
    PongData *newPongData = [[[self class]allocWithZone:zone]init];
    newPongData.ballLayout = self.ballLayout;
    newPongData.topBotLayout = self.topBotLayout;
    newPongData.bottomBotLayout = self.bottomBotLayout;
    return newPongData;
}

@end


#pragma mark - PongEngine Implementation

@implementation PongEngine

@synthesize currentData = currentData_;
@synthesize ballMovingDirection = ballMovingDirection_;


- (instancetype)init
{
    self = [super init];
    if (self) {
        currentData_ = [[PongData alloc]init];
        ballMovingDirection_ = directionDefault;
    }
    return self;
}

- (void) main
{
    __weak typeof(self) blockSelf = self;
    [self calculateStartData];
    dispatch_async(dispatch_get_main_queue(), ^{
        [blockSelf.delegate engine:blockSelf didCalculateNewData:[blockSelf.currentData copy]];
    });
    float usecSleepTime = (1/(float)self.frameRate)*1000000;
    while (YES) {
        usleep(usecSleepTime);
        [blockSelf calculateFrame];
        dispatch_async(dispatch_get_main_queue(), ^{
        [blockSelf.delegate engine:blockSelf didCalculateNewData:blockSelf.currentData];
        });
    }
}

- (void)calculateStartData
{
    [self.currentData setBallLayout:[NSValue valueWithCGRect:(CGRect){
        ballOrigin,
        ballSize
    }]];
    [self.currentData setTopBotLayout:[NSValue valueWithCGRect:(CGRect){
        botOrigin,
        botSize
    }]];
    [self.currentData setBottomBotLayout:[NSValue valueWithCGRect:(CGRect){
        botOrigin.x,
        self.gameAreaSize.height - botOrigin.y + botSize.height,
        botSize
    }]];
}

- (void)calculateFrame
{
    [self calculateBallMoving];
    if (self.topBotShouldMove) {
        self.currentData.topBotLayout = [self calculateBotMovingWithLayout:
            [self.currentData topBotLayout]];
    }
    else if (self.bottomBotShouldMove) {
        self.currentData.bottomBotLayout = [self calculateBotMovingWithLayout:
            [self.currentData bottomBotLayout]];
    }
}

- (void)calculateBallMoving
{
    CGRect newBallLayout = [self.currentData.ballLayout CGRectValue];
    switch (self.ballMovingDirection) {
        case directionSE: // Down-Right
            self.bottomBotShouldMove = YES;
            self.topBotShouldMove = NO;
            newBallLayout.origin.y = newBallLayout.origin.y + 1;
            newBallLayout.origin.x = newBallLayout.origin.x + 1;
            if (newBallLayout.origin.y >= self.gameAreaSize.height - ballSize.height
                - verticalBottomAsset) {
                self.ballMovingDirection = directionNE;
            }
            if (newBallLayout.origin.x >= self.gameAreaSize.width - ballSize.width
                - horizontalAsset) {
                self.ballMovingDirection = directionSW;
            }
        break;
        
        case directionSW: // Down-Left
            self.bottomBotShouldMove = YES;
            self.topBotShouldMove = NO;
            newBallLayout.origin.y = newBallLayout.origin.y + 1;
            newBallLayout.origin.x = newBallLayout.origin.x - 1;
            if (newBallLayout.origin.y >= self.gameAreaSize.height - ballSize.height
                - verticalBottomAsset) {
                self.ballMovingDirection = directionNW;
            }
            if (newBallLayout.origin.x == 0 + horizontalAsset) {
                self.ballMovingDirection = directionSE;
            }
        break;
        
        case directionNW: // Up-Left
            self.bottomBotShouldMove = NO;
            self.topBotShouldMove = YES;
            newBallLayout.origin.y = newBallLayout.origin.y - 1;
            newBallLayout.origin.x = newBallLayout.origin.x - 1;
            if (newBallLayout.origin.y == 0 + verticalTopAsset) {
                self.ballMovingDirection = directionSW;
            }
            if (newBallLayout.origin.x == 0 + horizontalAsset) {
                self.ballMovingDirection = directionNE;
            }
        break;
    
        case directionNE: // Up-Right
        default:
            self.bottomBotShouldMove = NO;
            self.topBotShouldMove = YES;
            newBallLayout.origin.y = newBallLayout.origin.y - 1;
            newBallLayout.origin.x = newBallLayout.origin.x + 1;
            if (newBallLayout.origin.y == 0 + verticalTopAsset) {
                self.ballMovingDirection = directionSE;
            }
            if (newBallLayout.origin.x >= self.gameAreaSize.width - ballSize.width
                - horizontalAsset) {
                self.ballMovingDirection = directionNW;
            }
        break;
    }
    [self.currentData setBallLayout:[NSValue valueWithCGRect:newBallLayout]];
}

- (NSValue/*With CGRect*/*)calculateBotMovingWithLayout:(NSValue/*With CGRect*/*)layout;
{
    CGRect botLayout = [layout CGRectValue];
    NSInteger aspireToX = [self.currentData.ballLayout CGRectValue].origin.x;
        if ((botLayout.origin.x + botLayout.size.width/2 < aspireToX) &&
            (botLayout.origin.x + botLayout.size.width < self.gameAreaSize.width
            - horizontalAsset)) {
                botLayout.origin.x = botLayout.origin.x + 1;
        }
        else if ((botLayout.origin.x + botLayout.size.width/2 > aspireToX) &&
            (botLayout.origin.x > 0 + horizontalAsset)){
                botLayout.origin.x = botLayout.origin.x - 1;
        }
    return [NSValue valueWithCGRect:botLayout];
}

@end
