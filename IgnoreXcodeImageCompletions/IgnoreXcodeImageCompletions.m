#import <objc/runtime.h>
#import "IgnoreXcodeImageCompletions.h"

@implementation IgnoreXcodeImageCompletions

+ (void)load {
    NSLog(@"IgnoreXcodeImageCompletions: Loading!");

    Class class = objc_getClass("IDEMediaLibraryCompletionStrategy");
    IMP fakeInitializer = imp_implementationWithBlock((id)^{
        NSLog(@"IgnoreXcodeImageCompletions: Fake initializer was called!");
        return nil;
    });

    Method objectInit = class_getInstanceMethod(objc_getClass("NSObject"), @selector(init));
    const char *encoding = method_getTypeEncoding(objectInit);

    BOOL added = class_addMethod(class, @selector(init), fakeInitializer, encoding);
    if (!added) {
        NSLog(@"IgnoreXcodeImageCompletions: Failed to add method :(");
        return;
    }

    NSLog(@"IgnoreXcodeImageCompletions: Swizzled selector!");
}

@end
