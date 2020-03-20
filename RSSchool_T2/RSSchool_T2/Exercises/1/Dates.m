#import "Dates.h"

@implementation Dates

- (NSString *)textForDay:(NSString *)day month:(NSString *)month year:(NSString *)year {
    
    NSString* inputString = [NSString stringWithFormat:@"%@|%@|%@",
    year, month, day];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy|MM|dd";
    NSDate *date = [dateFormatter dateFromString:inputString];
    
    if (date != nil) {
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ru_RU"];
        
        dateFormatter.locale = locale;
        dateFormatter.dateFormat = @"d MMMM, EEEE";
        
        [locale release];
        NSString *result = [dateFormatter stringFromDate:date];
        [dateFormatter release];
        return result;
    } else {
        [dateFormatter release];
        return @"Такого дня не существует";
    }
}

@end
