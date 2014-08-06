
#import "NumbersVC.h"

static NSString *const cellIdentifier = @"Cell";

@interface NumbersVC ()

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray /*Of NSNumbers*/ *mutableValues;

- (void) addValue:(NSNumber *)value;

@end

@implementation NumbersVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _mutableValues = [[NSMutableArray alloc]init];
        self.title = @"Fibonacci";
        self.tabBarItem.image = [UIImage imageNamed:@"fibonacci"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // TODO: Calculate new values
        unsigned long long temp_value = 0;
        unsigned long long old_temp_value = 0;
        unsigned long long new_temp_value = 0;
        for (int i = 0; i<50; i++) {
            if (temp_value == 0) {
                temp_value = 1;
            }
            else if ((temp_value == 1)&&(new_temp_value == 0)) {
                temp_value = 1;
                old_temp_value = 0;
                new_temp_value = 1;
            }
            else {
                new_temp_value = temp_value + old_temp_value;
                temp_value = new_temp_value;
                old_temp_value = temp_value - old_temp_value;
            }
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self addValue:[NSNumber numberWithLongLong:new_temp_value]];
            });
        }
    });
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.mutableValues count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
            reuseIdentifier:cellIdentifier];
    }
    NSString *stringValue = [NSString stringWithFormat:@"%@",self.mutableValues[indexPath.row]];
    cell.textLabel.text = stringValue;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void) addValue:(NSNumber *)value
{
    [self.mutableValues addObject:value];
    [self.tableView reloadData];
}

@end
