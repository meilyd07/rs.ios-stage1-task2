#import "Blocks.h"

@interface Blocks()
@property (nonatomic, copy) NSArray * arrayOfData;
@end

@implementation Blocks

- (instancetype)init
{
    self = [super init];
    if (self) {
        __block typeof(self) weakSelf = self;
        
        self.blockA = ^(NSArray * arr){
            weakSelf.arrayOfData = arr;
        };
        
        self.blockB = ^(Class classParameter){
            typeof(self) strongSelf = [weakSelf retain];
            NSArray *tempArray = strongSelf.arrayOfData;
            
            if (classParameter == NSClassFromString(@"NSNumber")) {
                int totalSum = 0;
                for (int i = 0; i < tempArray.count; i++) {
                    if ([tempArray[i] isKindOfClass:[NSNumber class]]) {
                        totalSum += [tempArray[i] intValue];
                    }
                }
                
                strongSelf.blockC(@(totalSum));
            } else if (classParameter == NSClassFromString(@"NSString")) {
                NSMutableString *concatString = [NSMutableString new];
                for (int i = 0; i < tempArray.count; i++) {
                    if ([tempArray[i] isKindOfClass:[NSString class]]) {
                        [concatString appendString:tempArray[i]];
                    }
                }
                
                strongSelf.blockC([concatString autorelease]);
            } else if (classParameter == NSClassFromString(@"NSDate")) {
                //Для дат — самая позняя дата в виде строки в формате dd.MM.yyyy
                
                
                int dateIndex = -1;
                
                for (int i = 0; i < tempArray.count; i++) {
                    if ([tempArray[i] isKindOfClass:[NSDate class]]) {
                        if (dateIndex < 0) {
                            dateIndex = i;
                        } else {
                            if ([tempArray[i] compare:tempArray[dateIndex]] == NSOrderedDescending) {
                                dateIndex = i;
                            }
                        }
                    }
                }
                
                if (dateIndex > 0) {
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                    dateFormatter.dateFormat = @"dd.MM.yyyy";
                    NSString *resultDateString = [dateFormatter stringFromDate:tempArray[dateIndex]];
                    [dateFormatter release];
                    strongSelf.blockC(resultDateString);
                }
                
            } else {
                NSLog(@"not found");
            }
            [strongSelf release];
        };
        
        _blockC = ^(NSObject *result){
            
        };
    }
    return self;
}

- (void)dealloc
{
    [_arrayOfData release];
    [_blockA release];
    [_blockB release];
    [_blockC release];
    [super dealloc];
}
@end
