#import "HclwFlutterPlugin.h"
#if __has_include(<hclw_flutter/hclw_flutter-Swift.h>)
#import <hclw_flutter/hclw_flutter-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "hclw_flutter-Swift.h"
#endif

@implementation HclwFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftHclwFlutterPlugin registerWithRegistrar:registrar];
}
@end
