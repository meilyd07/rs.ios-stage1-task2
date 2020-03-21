#import "AbbreviationMaker.h"

@implementation AbbreviationMaker
// Complete the abbreviation function below.
- (NSString *) abbreviationFromA:(NSString *)a toB:(NSString *)b {
    
    NSString *uppercasedA = [a uppercaseString];
    NSMutableOrderedSet *bSet = [self convertStringToSet:b];
    NSMutableOrderedSet *aSet = [self convertStringToSet:uppercasedA];
    
    [aSet intersectOrderedSet:bSet];
    
    if ([aSet isEqualToOrderedSet:bSet]) {
        return @"YES";
    } else {
        return @"NO";
    }
}

- (NSMutableOrderedSet *)convertStringToSet:(NSString *)string {
    
    NSMutableArray *characters = [[NSMutableArray alloc] initWithCapacity:[string length]];
    for (int i=0; i < [string length]; i++) {
        NSString *ichar  = [NSString stringWithFormat:@"%c", [string characterAtIndex:i]];
        [characters addObject:ichar];
    }
    
    NSMutableOrderedSet *setCharacters = [[NSOrderedSet orderedSetWithArray:characters] mutableCopy];
    [characters release];
    
    return [setCharacters autorelease];
}
@end
