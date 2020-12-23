
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
    UIViewController *topVC = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    while (topVC.presentedViewController)
    {
        topVC = topVC.presentedViewController;
    }
    if ([topVC isKindOfClass:[UINavigationController class]]) {
        return [(UINavigationController *)topVC topViewController];
    }
    return topVC;
}

RCT_REMAP_METHOD(exitApp, exitApp:(NSDictionary *)data) {
    dispatch_async(dispatch_get_main_queue(), ^{
//        UIViewController *navigationController = (UIViewController *)[[[[UIApplication sharedApplication] delegate] window] rootViewController];
//        [navigationController.presentedViewController dismissViewControllerAnimated:YES completion:nil];
        @try {
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:data
                             forKey:@"pkb_exit_data"];
            [userDefaults synchronize];
            [[self currentTopViewController] dismissViewControllerAnimated:YES completion:nil];
        }
        @catch(NSError *error) {
            NSLog(@"Error occured while exit %@", error);
        }

    });
}

@end
