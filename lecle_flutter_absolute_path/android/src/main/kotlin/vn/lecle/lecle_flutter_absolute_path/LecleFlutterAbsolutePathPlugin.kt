package vn.lecle.lecle_flutter_absolute_path

import android.content.Context
import android.net.Uri
import android.os.Build
import androidx.annotation.NonNull
import androidx.annotation.RequiresApi
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** LecleFlutterAbsolutePathPlugin */
class LecleFlutterAbsolutePathPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var context: Context

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "lecle_flutter_absolute_path")
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext
    }

    @RequiresApi(Build.VERSION_CODES.KITKAT)
    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "getAbsolutePath" -> {
                val args = call.arguments as Map<*, *>
                val uriString = args["uri"] as String
                val uri = Uri.parse(uriString)
                val outputFileName = args["outputFileName"] as? String
                val fileExtension = args["fileExtension"] as? String

//                val provider = applicationProviders?.firstOrNull { uri.authority == it.authority }
//                if (provider != null) {
//                    val folderPath = Environment.getExternalStorageDirectory().path + "/Pictures"
//                    result.success("$folderPath/${uri.lastPathSegment}")
//                    return
//                }

                result.success(FileDirectory.getAbsolutePath(this.context, uri, outputFileName, fileExtension))
            }
            else -> result.notImplemented()
        }
    }

    //    val applicationProviders: List<ProviderInfo>? by lazy {
//        val applicationId = context.packageName
//        context.packageManager
//                .getInstalledPackages(PackageManager.GET_PROVIDERS)
//                .firstOrNull { it.packageName == applicationId }
//                ?.providers?.toList()
//    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(binding.binaryMessenger, "lecle_flutter_absolute_path")
        channel.setMethodCallHandler(this)
    }
}
