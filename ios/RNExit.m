
#import "RNExit.h"

@implementation RNExit

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

- (BOOL)requiresMainQueueSetup
{
 return YES;
}

RCT_EXPORT_MODULE()

- (UIViewController *)currentTopViewController
{
    UIViewController *topVC;
    if (@available(iOS 13, *)){
        topVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    } else {
        topVC = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    }
    while (topVC.presentedViewController)
    {
        topVC = topVC.presentedViewController;
    }
    if ([topVC isKindOfClass:[UINavigationController class]]) {
        return [(UINavigationController *)topVC topViewController];
    }
    return topVC;
}

RCT_REMAP_METHOD(exitApp,
                 exitApp:(NSDictionary *)data
                //  withNavigationExitType:(NSString *)navigationExitType
                 ) {
    dispatch_async(dispatch_get_main_queue(), ^{
        @try {
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:data
                             forKey:@"pkb_exit_data"];
            [userDefaults synchronize];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"PeekabooConnectExit" object:nil userInfo:data];
            // if ([navigationExitType isEqualToString:@"POP"]) {
            //     [[self currentTopViewController] popoverPresentationController];
            //     return;
            // }
            [[self currentTopViewController] dismissViewControllerAnimated:YES completion:nil];
        }
        @catch(NSError *error) {
            NSLog(@"Error occured while exit %@", error);
        }

    });
}

@end
