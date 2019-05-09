#import "FlutterNativeWidgetsPlugin.h"
#import <flutter_native_widgets/flutter_native_widgets-Swift.h>

@implementation FlutterNativeWidgetsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterNativeWidgetsPlugin registerWithRegistrar:registrar];
}
@end
