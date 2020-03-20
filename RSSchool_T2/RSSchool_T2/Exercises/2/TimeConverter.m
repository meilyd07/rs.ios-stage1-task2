#import "TimeConverter.h"

@implementation TimeConverter
// Complete the following function
- (NSString*)convertFromHours:(NSString*)hours minutes:(NSString*)minutes {
    
    if ((hours.length <= 2) &&
        (hours.length > 0) &&
        (minutes.length <= 2) &&
        (minutes.length > 0)) {
        
        NSCharacterSet *notDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];

        if (([hours rangeOfCharacterFromSet:notDigits].location == NSNotFound) && ([minutes rangeOfCharacterFromSet:notDigits].location == NSNotFound)) {
            //only digits
            
            int integerHourValue = [hours intValue];
            int integerMinuteValue = [minutes intValue];
            
            //check rules
            //At minutes = 0, use o' clock. For 1 <= minutes <= 30, use past, and for 30 < minutes use to.
            if ((integerHourValue == 0) || (integerHourValue >= 24)) {
                return @"";
            }
            
            if (integerMinuteValue == 0) {

                int hourUnits = integerHourValue % 10;
                int hourTens = integerHourValue / 10;
                return [NSString stringWithFormat:@"%@ o' clock", [self tensNumber:hourTens andUnitToWord:hourUnits]];
            } else {
                if ((integerMinuteValue >= 1) && (integerMinuteValue <= 30)) {
                    //use past
                    
                    int minuteUnits = integerMinuteValue % 10;
                    int minuteTens = integerMinuteValue / 10;
                    int hourUnits = integerHourValue % 10;
                    int hourTens = integerHourValue / 10;

                    return [NSString stringWithFormat:@"%@ past %@", [self resultMinutesLabeledTensNumber:minuteTens andUnitToWord:minuteUnits], [self tensNumber:hourTens andUnitToWord:hourUnits]];
                    
                } else if ((integerMinuteValue > 30) && (integerMinuteValue <= 59)) {
                    //use to
                    int nextHourValue = integerHourValue + 1;
                    int hourUnits = nextHourValue % 10;
                    int hourTens = nextHourValue / 10;
                    
                    int lastMinutesValue = 60 - integerMinuteValue;
                    int minuteUnits = lastMinutesValue % 10;
                    int minuteTens = lastMinutesValue / 10;
                    
                    return [NSString stringWithFormat:@"%@ to %@", [self resultMinutesLabeledTensNumber:minuteTens andUnitToWord:minuteUnits], [self tensNumber:hourTens andUnitToWord:hourUnits]];
                } else {
                    return @"";
                }
            }
        } else {
            return @"";
        }
        
    } else {
        return @"";
    }
}

- (NSString *)resultMinutesLabeledTensNumber:(int)tensNumber andUnitToWord:(int)unitsNumber {
    
    NSString *minutesText = [self tensNumber:tensNumber andUnitToWord:unitsNumber];
    
    NSString *resultMinutesLabeled = @"";
    if ([minutesText isEqualToString:@"one"]) {
        resultMinutesLabeled = @"one minute";
    } else if ([minutesText isEqualToString:@"fifteen"]) {
        resultMinutesLabeled = @"quarter";
    } else if ([minutesText isEqualToString:@"thirty"]) {
        resultMinutesLabeled = @"half";
    } else {
        resultMinutesLabeled = [NSString stringWithFormat:@"%@ minutes", minutesText];
    }
        
    return resultMinutesLabeled;
}

- (NSString *)unitsNumberToWord:(int)number {
    
    NSArray *array = @[@"", @"one", @"two", @"three", @"four", @"five", @"six", @"seven", @"eight", @"nine"];
    return ((number >= 0) && (number < 10)) ? array[number] : @"";
}

- (NSString *)tensNumber:(int)tensNumber andUnitToWord:(int)unitsNumber {
    NSString *result = @"";
    
    if (tensNumber == 0) {
        result = [self unitsNumberToWord:unitsNumber];
    } else if (tensNumber == 1) {
        
        NSArray *tensArray = @[@"ten", @"eleven", @"twelve", @"thirteen", @"fourteen", @"fifteen", @"sixteen", @"seventeen", @"eighteen", @"nineteen"];
        result = tensArray[unitsNumber];
    } else if ((tensNumber >= 2) && (tensNumber < 6)) {
        NSArray *listTensArray = @[@"twenty", @"thirty", @"forty", @"fifty"];
        int index = tensNumber - 2;
        result = listTensArray[index];
        
        if (unitsNumber == 0) {
            result = listTensArray[index];
        } else {
            result = [NSString stringWithFormat:@"%@ %@", listTensArray[index], [self unitsNumberToWord:unitsNumber]];
        }
        
    } else {
        result = @"";
    }
    
    return result;
}
@end
