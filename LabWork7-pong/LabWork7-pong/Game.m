

#import "Game.h"


static CGPoint const ballOrigin = {100, 100};
static CGSize const ballSize = {20, 20};

static CGPoint const platformOrigin = {20,40};
static CGSize const platformSize = {120, 20};


typedef NS_ENUM(NSInteger, Direction) {
    directionNE = 0,
    directionSE = 1,
    directionSW = 2,
    directionNW = 3,
    directionDefault = directionNE
};


@interface Game ()

@property (nonatomic) Direction ballDirection;


- (void)setStartLayouts;
- (void)calculateBallPosition;
- (void)calculatePlatformsPosition;

@end


@implementation Game

- (instancetype)init
{

    if (self = [super init])
    {
        _ballDirection = directionDefault;
    }
    return self;
}


- (void)setStartLayouts
{
    CGRect rectBall = (CGRect){
        ballOrigin,
        ballSize
    };
    self.ballLayout = [NSValue value:&rectBall withObjCType:@encode(CGRect)];
     CGRect rectTopPlatform = (CGRect){
         platformOrigin,
         platformSize
     };
     
    self.topPlatformLayout = [NSValue value:&rectTopPlatform withObjCType:@encode(CGRect)];
    
    CGRect bottomPlatform = (CGRect){
        platformOrigin.x,
        self.gameAreaSize.height - platformSize.height,
        platformSize
    };
    
    self.bottomPlatformLayout = [NSValue value:&bottomPlatform withObjCType:@encode(CGRect)];
}

- (void)calculateBallPosition
{
    CGRect newBallLayout;
    [self.ballLayout getValue:&newBallLayout];
    CGRect rectBottomPlatformLayout;
    [self.ballLayout getValue:&rectBottomPlatformLayout];
    CGRect rectTopPlatformLayout;
    [self.ballLayout getValue:&rectTopPlatformLayout];
    
    switch (self.ballDirection)
    {
        case directionSE:
            newBallLayout.origin.y = newBallLayout.origin.y + 1;
            newBallLayout.origin.x = newBallLayout.origin.x + 1;
            if (newBallLayout.origin.y >= self.gameAreaSize.height - ballSize.height
                - rectBottomPlatformLayout.size.height)
            {
                self.ballDirection = directionNE;
            }
            if (newBallLayout.origin.x >= self.gameAreaSize.width - ballSize.width)
            {
                self.ballDirection = directionSW;
            }
            break;
            
        case directionSW:
            
            newBallLayout.origin.y = newBallLayout.origin.y + 1;
            newBallLayout.origin.x = newBallLayout.origin.x - 1;
            if (newBallLayout.origin.y >= self.gameAreaSize.height - ballSize.height
                - rectBottomPlatformLayout.size.height)
            {
                self.ballDirection = directionNW;
            }
            if (newBallLayout.origin.x <= 0)
            {
                self.ballDirection = directionSE;
            }
            break;
            
        case directionNW:
            
            newBallLayout.origin.y = newBallLayout.origin.y - 1;
            newBallLayout.origin.x = newBallLayout.origin.x - 1;
            if (newBallLayout.origin.y <= platformOrigin.y + platformSize.height)
            {
                self.ballDirection = directionSW;
            }
            if (newBallLayout.origin.x <= 0)
            {
                self.ballDirection = directionNE;
            }
            break;
            
        case directionNE:
            
            newBallLayout.origin.y = newBallLayout.origin.y - 1;
            newBallLayout.origin.x = newBallLayout.origin.x + 1;
            if (newBallLayout.origin.y <= platformOrigin.y + platformSize.height)
            {
                self.ballDirection = directionSE;
            }
            if (newBallLayout.origin.x >= self.gameAreaSize.width - ballSize.width)
            {
                self.ballDirection = directionNW;
            }
            break;
    }
    self.ballLayout = [NSValue value:&newBallLayout withObjCType:@encode(CGRect)];
}

- (void)calculatePlatformsPosition
{
    CGRect rectBottomPlatformLayout;
    [self.bottomPlatformLayout getValue:&rectBottomPlatformLayout];
    CGRect rectTopPlatformLayout;
    [self.topPlatformLayout getValue:&rectTopPlatformLayout];
    CGRect rectBallLayout;
    [self.ballLayout getValue:&rectBallLayout];
    if ((rectBottomPlatformLayout.origin.x + rectBottomPlatformLayout.size.width/2 < rectBallLayout.origin.x) &&
        (rectBottomPlatformLayout.origin.x + rectBottomPlatformLayout.size.width < self.gameAreaSize.width))
    {
        rectBottomPlatformLayout.origin.x = rectBottomPlatformLayout.origin.x + 1;
        rectTopPlatformLayout.origin.x = rectTopPlatformLayout.origin.x + 1;
    }
    else if ((rectBottomPlatformLayout.origin.x + rectBottomPlatformLayout.size.width/2 > rectBallLayout.origin.x) &&
             (rectBottomPlatformLayout.origin.x > 0))
    {
        rectBottomPlatformLayout.origin.x = rectBottomPlatformLayout.origin.x - 1;
        rectTopPlatformLayout.origin.x = rectTopPlatformLayout.origin.x - 1;
    }
    self.bottomPlatformLayout = [NSValue value:&rectBottomPlatformLayout withObjCType:@encode(CGRect)];
    self.topPlatformLayout = [NSValue value:&rectTopPlatformLayout withObjCType:@encode(CGRect)];
}








@end
