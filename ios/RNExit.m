
#import "RNExit.h"

@implementation RNExit

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}
RCT_EXPORT_MODULE()

RCT_REMAP_METHOD(exitApp) {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIViewController *navigationController = (UIViewController *)[[[[UIApplication sharedApplication] delegate] window] rootViewController];
        [navigationController.presentedViewController dismissViewControllerAnimated: YES completion:nil];
    });
}

@end
  