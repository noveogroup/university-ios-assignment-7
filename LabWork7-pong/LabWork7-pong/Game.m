

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







@end
