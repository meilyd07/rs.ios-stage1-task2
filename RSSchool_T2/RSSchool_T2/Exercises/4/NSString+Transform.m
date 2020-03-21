#import "NSString+Transform.h"

@implementation NSString (Transform)

-(NSString*)transform {
    
    NSString *fixed = [self stringByReplacingOccurrencesOfString:@"\\s+"
    withString:@" "
       options:NSRegularExpressionSearch
         range:NSMakeRange(0, self.length)];
    
    NSSet *vowelsSets = [[NSSet alloc] initWithObjects:@"a", @"e", @"i", @"o", @"u", @"y", @"A", @"E", @"I", @"O", @"U", @"Y", nil];
    NSSet *consonantsSet = [[NSSet alloc] initWithObjects:@"b", @"c", @"d", @"f", @"g", @"h", @"j", @"k", @"l", @"m", @"n", @"p", @"q", @"r", @"s", @"t", @"v", @"x", @"z", @"w", @"B", @"C", @"D", @"F", @"G", @"H", @"J", @"K", @"L", @"M", @"N", @"P", @"Q", @"R", @"S", @"T", @"V", @"X", @"Z", @"W", nil];
    
    if ([fixed isPangram]) {
        return [self sortWordsInString:fixed bySet:vowelsSets];
        
    } else {
        return [self sortWordsInString:fixed bySet:consonantsSet];
    }
}

- (NSString *)sortWordsInString:(NSString *)string bySet:(NSSet *)set {
    
    NSMutableArray *pairs = [NSMutableArray new];
    NSArray *words  = [string componentsSeparatedByString:@" "];
    NSMutableString *resultWords = [NSMutableString new];
    
    for (NSString *itemString in words) {
        if ([[itemString stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet] length] > 0) {
            NSArray *pair = [self countAndCapitalizeCharactersInSet:set inWord:itemString];
            [pairs addObject:pair];
        }
    }
    
    NSArray *sortedArray = [pairs sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        NSNumber *first = [(NSArray *)a objectAtIndex:0];
        NSNumber *second = [(NSArray *)b objectAtIndex:0];
        
        return [first compare:second];
    }];
    
    for (int i = 0; i < sortedArray.count; i++) {
        NSString *string = sortedArray[i][1];
        if (i > 0) {
            [resultWords appendString:@" "];
        }
        [resultWords appendString:string];
    }
    NSLog(@"%@", resultWords);
    return [resultWords autorelease];
}

- (NSArray *)countAndCapitalizeCharactersInSet:(NSSet *)set inWord:(NSString *)string {
    
    NSMutableArray *characters = [[NSMutableArray alloc] initWithCapacity:[string length]];
    int count = 0;
    for (int i = 0; i < [string length]; i++) {
        NSString *ichar  = [NSString stringWithFormat:@"%C", [string characterAtIndex:i]];
        if ([set containsObject:ichar]) {
            count++;
            [characters addObject:[ichar uppercaseString]];
        } else {
            [characters addObject:ichar];
            
        }
    }
    NSString *resultWord = [NSString stringWithFormat:@"%d%@", count, [characters componentsJoinedByString:@""]];
    [characters release];
    return @[@(count), resultWord];
}

- (BOOL)isPangram{
    
    NSError *error = nil;
    NSString *pattern = @"(?=.*a)(?=.*b)(?=.*c)(?=.*d)(?=.*e)(?=.*f)(?=.*g)(?=.*h)(?=.*i)(?=.*j)(?=.*k)(?=.*l)(?=.*m)(?=.*n)(?=.*o)(?=.*p)(?=.*q)(?=.*r)(?=.*s)(?=.*t)(?=.*u)(?=.*v)(?=.*w)(?=.*x)(?=.*y)(?=.*z)";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:&error];
    NSArray<NSTextCheckingResult *> *matches = [regex matchesInString:[self lowercaseString] options:0 range:NSMakeRange(0, self.length)];
    
    if (matches.count > 0) {
        return YES;
    } else {
        return NO;
    }
}

@end
