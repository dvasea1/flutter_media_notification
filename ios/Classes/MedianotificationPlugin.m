#import "MedianotificationPlugin.h"
#if __has_include(<medianotification/medianotification-Swift.h>)
#import <medianotification/medianotification-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "medianotification-Swift.h"
#endif

@implementation MedianotificationPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftMedianotificationPlugin registerWithRegistrar:registrar];
}
@end
