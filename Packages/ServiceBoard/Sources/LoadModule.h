#import <Foundation/Foundation.h>

//! Project version number for SwiftyLoad.
FOUNDATION_EXPORT double SwiftyLoadVersionNumber;

//! Project version string for SwiftyLoad.
FOUNDATION_EXPORT const unsigned char SwiftyLoadVersionString[];

@protocol ModuleLoadable <NSObject>
@optional
+ (void)onModuleLoad;
+ (void)onModuleInitialize;
@end

#define MODULE_EXPORT(className) \
@interface className(swizzle_swifty_hook)\
@end\
\
@implementation className(swizzle_swifty_hook)\
+ (void)load {if ([[self class] respondsToSelector:@selector(onModuleLoad)]) {[[self class] onModuleLoad];}}\
+ (void)initialize {if ([[self class] respondsToSelector:@selector(onModuleInitialize)]) {[[self class] onModuleInitialize];}}\
@end
