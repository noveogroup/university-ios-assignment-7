#import "MyItem.h"

@implementation MyItem
@synthesize  Number;

+(id)randomItem {// реализация элемента randomItem используемый для создания, конфигурирования и возврата экземпляра класса MyItem
   
    NSString *randomNumber = [NSString stringWithFormat:@"A%c%c%c%c%c",
                              
                                    '0' + rand() %10,
                                    'A' + rand() %26,
                                    '0' + rand() %10,
                                    'A' + rand() %26,
                                    '0' + rand() %10];
    
    MyItem *newItem = [[self alloc]initWithRNumber:randomNumber];
    
                       return newItem;
    
}

-(id)initWithRNumber:(NSString *)sNumber{//это выделенный инициализатор вызывает выделенный инициализатор супер класса
    self = [super init];
    
    //успешно ли завершен вызов?
    if(self) {
        //присвоение начальных значений переменным экземпляра класса
        
        [self setNumber:sNumber];
        
    }
        return self;
}

-(id)init {//переопределяем метод init для используемый для вызова designated инициализатора со значениями заданными по умолчанию для всех аргументов
    return [self initWithRNumber:@""];
}


@end
