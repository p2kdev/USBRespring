@interface FBSystemService : NSObject
  +(id)sharedInstance;
  -(void)exitAndRelaunch:(BOOL)arg1;
@end

@interface MPPlayableContentManagerContext
  @property (assign,nonatomic) BOOL endpointAvailable;
  -(void)setEndpointAvailable:(BOOL)arg1;
@end

@interface MPPlayableContentDelegate
-(void)playableContentManager:(id)arg1 didUpdateContext:(MPPlayableContentManagerContext *)arg2;
@end

static void respring() {
  //reloadSettings();
  [[%c(FBSystemService) sharedInstance] exitAndRelaunch:YES];
}

%hook MPPlayableContentDelegate

  -(void)playableContentManager:(id)arg1 didUpdateContext:(MPPlayableContentManagerContext *)arg2
  {
    %orig;
    if (!arg2.endpointAvailable)
    {
      respring();
    }
  }

%end
// static void _callback(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo)
// {
//     if ([(__bridge NSString*)name isEqualToString:@"com.apple.mobile.lockdown.host_detached"])
//     {
//       respring();
//       // NSString *msg = [NSString stringWithFormat:@"USB DisConnected!"];
//       // UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"USBRespring"
//       //                              message:msg
//       //                              preferredStyle:UIAlertControllerStyleAlert];
//       // UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
//       //  handler:^(UIAlertAction * action) {}];
//       //
//       //  [alert addAction:defaultAction];
//       // [[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:alert animated:YES completion:nil];
//
//     }
// }

//CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo

// %ctor {
//   //CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, _callback, CFSTR("com.apple.mobile.lockdown.host_attached"), NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
//   //CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, respring, CFSTR("com.apple.mobile.lockdown.host_detached"), NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
// }
