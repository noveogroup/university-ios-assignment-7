
#import "SEAppDelegate.h"
#import "NumbersVC.h"


@interface SEAppDelegate ()

@property (nonatomic, strong) UITabBarController *rootVC;
@property (nonatomic, strong) NumbersVC *numbersVC;

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
    [self.rootVC setViewControllers:@[self.numbersVC]];
    [self.window setRootViewController:self.rootVC];
    
    return YES;
}


@end
