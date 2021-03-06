#import "InstagramCropperPlugin.h"
#if __has_include(<instagram_cropper/instagram_cropper-Swift.h>)
#import <instagram_cropper/instagram_cropper-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "instagram_cropper-Swift.h"
#endif

@implementation InstagramCropperPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftInstagramCropperPlugin registerWithRegistrar:registrar];
}
@end
