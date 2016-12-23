//
//  PongVC.m
//  NoveoHomework-7
//
//  Created by Wadim on 8/6/14.
//  Copyright (c) 2014 Smirnov Electronics. All rights reserved.
//

#import "PongVC.h"

#define IS_WIDESCREEN ([[UIScreen mainScreen]bounds].size.height == 568)

static NSInteger defaultFrameRate = 60;

static NSInteger const wideScreenHeigth = 568;
static NSInteger const screenHeigth = 480;
static NSInteger const screenWidth = 320;

static NSInteger const tapBarHeight = 49;
static NSInteger const statusBarHeight = 20;


#pragma mark - PongVC Extension

@interface PongVC ()

@property (nonatomic, strong) UIView *topBot;
@property (nonatomic, strong) UIView *bottomBot;
@property (nonatomic, strong) UIView *ball;

@end


#pragma mark - PongVC Implementation

@implementation PongVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Pong";
        self.tabBarItem.image = [UIImage imageNamed:@"pong"];
        // Create new pong Engine
        PongEngine *newEngine = [[PongEngine alloc]init];
        // Configure Engine
        CGSize gameAreaSize = {
           screenWidth,
           screenHeigth - tapBarHeight - statusBarHeight
        };
        if (IS_WIDESCREEN) {
            gameAreaSize.height = wideScreenHeigth - tapBarHeight - statusBarHeight;
        }
        newEngine.gameAreaSize = gameAreaSize;
        newEngine.delegate = self;
        newEngine.frameRate = defaultFrameRate;
        // Start engine
        [newEngine start];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Create THE ball
    self.ball = [[UIView alloc]init];
    self.ball.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.ball];
    // Create a top Bot
    self.topBot = [[UIView alloc]init];
    self.topBot.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.topBot];
    // Create a bottom Bot
    self.bottomBot = [[UIView alloc]init];
    self.bottomBot.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.bottomBot];
}


#pragma mark - PongEngineDelegate Protocol Methods

- (void)engine:(PongEngine *)engine didCalculateNewData:(PongData *)data
{
    if (self.view) {
        [self.ball setFrame:[data.ballLayout CGRectValue]];
        [self.topBot setFrame:[data.topBotLayout CGRectValue]];
        [self.bottomBot setFrame:[data.bottomBotLayout CGRectValue]];
    }
}


@end
