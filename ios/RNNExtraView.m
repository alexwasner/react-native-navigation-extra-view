#import <React/RCTRootView.h>
#import "RNNExtraView.h"
#import "RNNExtraViewWrapper.h"
#import "RCCManager.h"

@implementation RNNExtraView

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}
RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(createView:(NSString*)subViewName props:(NSDictionary*)props resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
    
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    if (!window)
        window = [[UIApplication sharedApplication].windows objectAtIndex:0];

    RCTRootView *subView = [[RCTRootView alloc] initWithBridge:[[RCCManager sharedInstance] getBridge] moduleName:subViewName initialProperties: props];
    
    UIView *overlayView = [[RNNExtraViewWrapper alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) subView:subView];
    if (subView == nil)
    {
        [RNNExtraView handleRCTPromiseRejectBlock:reject
                                                error:[RNNExtraView extraViewErrorWithCode:-100 description:@"could not create controller"]];
        return;
    }
    [[[window subviews] objectAtIndex:0] addSubview:overlayView];
    [overlayView addSubview:subView];
}

+(NSError*)extraViewErrorWithCode:(NSInteger)code description:(NSString*)description
{
    NSString *safeDescription = (description == nil) ? @"" : description;
    return [NSError errorWithDomain:@"RNNExtraView" code:code userInfo:@{NSLocalizedDescriptionKey: safeDescription}];
}

+(void)handleRCTPromiseRejectBlock:(RCTPromiseRejectBlock)reject error:(NSError*)error
{
    reject([NSString stringWithFormat: @"%lu", (long)error.code], error.localizedDescription, error);
}
@end
