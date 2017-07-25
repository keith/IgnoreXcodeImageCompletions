#import <objc/runtime.h>
#import "IgnoreXcodeImageCompletions.h"

@implementation IgnoreXcodeImageCompletions

+ (void)load {
    NSLog(@"IgnoreXcodeImageCompletions: Loading!");
    IMP replacement = imp_implementationWithBlock((NSString *)^{ return nil; });
    Class class = objc_getClass("IDEMediaResourceCompletionItem");
    Method originalMethod = class_getInstanceMethod(class, @selector(name));
    const char* encoding = method_getTypeEncoding(originalMethod);
    SEL newSelector = NSSelectorFromString(@"ixic_setName:");
    BOOL added = class_addMethod(class, newSelector, replacement, encoding);

    if (!added) {
        NSLog(@"IgnoreXcodeImageCompletions: Failed to add selector");
        return;
    }

    Method newMethod = class_getInstanceMethod(class, newSelector);
    method_exchangeImplementations(originalMethod, newMethod);
}

@end
