#import "MyItemStore.h"
#import "MyItem.h"

@implementation MyItemStore



+(MyItemStore*)sharedStore {
    
    static MyItemStore *sharedStore = nil;//статическая переменная не находится в стеке и не уничтожается после
    //возврата метода она обьявляется лишь раз и никогда не уничтожается //и никто не может ее использовать
    if (!sharedStore)
        sharedStore = [[super allocWithZone:nil] init];
    
    return sharedStore;
}

+(id)allocWithZone:(struct _NSZone *)zone {
    return [self sharedStore];
}

-(MyItem *)createItem {
    
    MyItem *p = [MyItem randomItem];
    [allItems addObject:p];
    return p;
}


@end
