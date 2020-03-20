#import "Blocks.h"

@implementation Blocks

- (instancetype)init
{
    self = [super init];
    if (self) {
        _blockA = ^(NSArray * arr){};
        _blockB = ^(Class classParameter){};
        _blockC = ^(NSObject *result){};
    }
    return self;
}
@end
