#import "FibonacciResolver.h"

@implementation FibonacciResolver
- (NSArray*)productFibonacciSequenceFor:(NSNumber*)number {
    NSMutableArray *fibonacciArray = [NSMutableArray new];
    NSInteger productNumber = [number intValue];
    
    for (int i = 0; i <= [number intValue]; i++) {
        [fibonacciArray addObject:[self getFibonacci:i]];
    }
    
    NSUInteger j = 1;
    NSUInteger count = fibonacciArray.count - 1;
    NSUInteger resultIndex = -1;
    
    while (j < count) {
        NSUInteger previous = [fibonacciArray[j-1] unsignedIntegerValue];
        NSUInteger current = [fibonacciArray[j] unsignedIntegerValue];
        NSUInteger previousMultiply = previous * current;
        if (previousMultiply <= productNumber) {
            resultIndex = j - 1;
            if (previousMultiply == productNumber) {
                break;
            }
        } else {
            resultIndex = j - 1;
            break;
        }
        j++;
    }
    
    if (resultIndex > 0) {
        return @[fibonacciArray[resultIndex], fibonacciArray[resultIndex + 1], ([fibonacciArray[resultIndex] unsignedIntegerValue] * [fibonacciArray[resultIndex + 1] unsignedIntegerValue]) == productNumber ? @1 : @0];
    } else {
        return @[];
    }
}

- (NSNumber *) getFibonacci:(NSInteger)number {
    NSUInteger a = 0;
    NSUInteger b = 1;
    
    int i = 0;
    while (i < number) {
        NSUInteger tempValue = a;
        a = b;
        b = tempValue + b;
        i++;
    }
    return @(a);
}
@end
