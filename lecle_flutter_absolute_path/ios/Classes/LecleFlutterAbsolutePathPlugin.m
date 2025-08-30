#import "LecleFlutterAbsolutePathPlugin.h"
#if __has_include(<lecle_flutter_absolute_path/lecle_flutter_absolute_path-Swift.h>)
#import <lecle_flutter_absolute_path/lecle_flutter_absolute_path-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "lecle_flutter_absolute_path-Swift.h"
#endif

@implementation LecleFlutterAbsolutePathPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
[SwiftLecleFlutterAbsolutePathPlugin registerWithRegistrar:registrar];
    //FlutterMethodChannel* channel = [FlutterMethodChannel
      //                               methodChannelWithName:@"lecle_flutter_absolute_path"
        //                             binaryMessenger:[registrar messenger]];
    // LecleFlutterAbsolutePathPlugin* instance = [[LecleFlutterAbsolutePathPlugin alloc] init];
    // [registrar addMethodCallDelegate:instance channel:channel];
}

//- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
//    if ([call.method isEqualToString:@"getAbsolutePath"]) {
//
//        NSDictionary<NSString *, NSString *> *dict = [NSDictionary<NSString *, NSString *> typecastWithAssertion:[call.arguments]];
//        if([dictionary objectForKey:@"uri"] != nil) {
//            NSString *uri = dict[@"uri"];
//
//            if ([uri hasPrefix:@"file://"] || [uri hasPrefix:@"/var/mobile/Media"] || [uri hasPrefix:@"/private/var/mobile"]) {
//                [uri stringByReplacingOccurrencesOfString:@"file://"
//                                               withString:@""]
//                result([uri stringByReplacingOccurrencesOfString:@"file://"
//                                                      withString:@""]);
//                return;
//            }
//
//            NSURL *url = [NSURL URLWithString:@uri];
//            PHFetchResult *phAssetFetchResult = [PHAsset fetchAssetsWithALAssetURLs:@[url ] options:nil];
//            PHAsset* phAsset = [phAssetFetchResult firstObject];
//            if(phAsset == nil) {
//                result(nil);
//                return;
//            }
//            PHContentEditingInputRequestOptions *editingOptions = [[PHContentEditingInputRequestOptions alloc] init];
//            editingOptions.isNetworkAccessAllowed = true;
//            // Can not continue from here
//            [phAsset requestContentEditingInput:^(PHContentEditingInput input) {
//
//            } options:editingOptions]
//
//            phAsset.requestContentEditingInput(with: editingOptions) { (input, _) in;
//                let url = input?.fullSizeImageURL?.absoluteString.replacingOccurrences(of: "file://", with: "");
//                result(url);
//            }
//        } else {
//            result(FlutterMethodNotImplemented);
//        }
//    } else {
//        result(FlutterMethodNotImplemented);
//    }
//}
//
//@interface NSObject (TypecastWithAssertion)
//+ (instancetype)typecastWithAssertion:(id)object;
//@end
//
//
//@implementation NSObject (TypecastWithAssertion)
//+ (instancetype)typecastWithAssertion:(id)object {
//    if (object != nil)
//        NSAssert([object isKindOfClass:[self class]], @"Object %@ is not kind of class %@", object, NSStringFromClass([self class]));
//    return object;
//}
//@end

@end
