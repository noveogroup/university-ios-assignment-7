
#import <Foundation/Foundation.h>

@class MyItem;

@interface MyItemStore : NSObject
{
    NSMutableArray *allItems;
}

+(MyItemStore*)sharedStore;

-(MyItem *)createItem;


@end
