
#import "ViewController.h"
#import "PrimeNumberService.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSArray *primeNumberArray;
@property (nonatomic, strong) PrimeNumberService *primeService;
@end

@implementation ViewController

@synthesize primeNumberArray = primeNumberArray_;

-(NSArray*) primeNumberArray{
    if (primeNumberArray_ == nil)
        primeNumberArray_ = [NSArray array];
    
    return primeNumberArray_;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.primeService = [[PrimeNumberService alloc] init];
    
    __typeof(PrimeNumberService) __weak *primeServiceWeak = self.primeService;
    
    CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(reReadNumbers)];
    [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        [primeServiceWeak start];
    });
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self primeNumberArray] count];
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
#define REUSABLE_CELL_ID @"ReusableCellID"
    
    UITableViewCell *tableViewCell =
    [tableView dequeueReusableCellWithIdentifier:REUSABLE_CELL_ID];
    if (!tableViewCell) {
        tableViewCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2
                                               reuseIdentifier:REUSABLE_CELL_ID];
    }
    
    tableViewCell.textLabel.text = [self primeNumberArray][indexPath.row];
    
    return tableViewCell;
    
#undef REUSABLE_CELL_ID
}

-(void) reReadNumbers{
    self.primeNumberArray = [[self.primeService primeNumbers] copy];
    [self.tableView reloadData];
}


@end
