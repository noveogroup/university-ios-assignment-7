
#import "SEAppDelegate.h"
#import "NumbersVC.h"
#import "PongVC.h"


@interface SEAppDelegate ()

@property (nonatomic, strong) UITabBarController *rootVC;
@property (nonatomic, strong) NumbersVC *numbersVC;
@property (nonatomic, strong) PongVC *pongVC;

@end

@implementation SEAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    self.rootVC = [[UITabBarController alloc]init];
    self.numbersVC = [[NumbersVC alloc]init];
    self.numbersVC.view.backgroundColor = [UIColor lightGrayColor];
    self.pongVC = [[PongVC alloc]init];
    self.pongVC.view.backgroundColor = [UIColor darkGrayColor];
    [self.rootVC setViewControllers:@[self.numbersVC, self.pongVC]];
    [self.window setRootViewController:self.rootVC];
    
    return YES;
}


@end
