package pro.modernwizard.manifest_info_reader

import android.content.Context
import android.content.pm.PackageManager
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** ManifestInfoReaderPlugin */
class ManifestInfoReaderPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var context: Context

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "manifest_info_reader")
    channel.setMethodCallHandler(this)
    context = flutterPluginBinding.applicationContext
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
      "getValue" -> {
        val key = call.argument<String>("key")
        if (key == null) {
          result.error("INVALID_ARGUMENTS", "Missing 'key' parameter", null)
          return
        }
        result.success(getManifestValue(key))
      }
      "getAndroidManifestXmlValues" -> {
        result.success(getAllManifestValues())
      }
      else -> {
        result.notImplemented()
      }
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  private fun getManifestValue(key: String): Any? {
    try {
      val appInfo = context.packageManager.getApplicationInfo(
        context.packageName,
        PackageManager.GET_META_DATA
      )

      // First try to get from meta-data
      if (appInfo.metaData != null && appInfo.metaData.containsKey(key)) {
        return appInfo.metaData.get(key)
      }

      // Try to get from resources if it's a resource identifier
      val resourceId = context.resources.getIdentifier(key, "string", context.packageName)
      if (resourceId != 0) {
        return context.getString(resourceId)
      }

      return null
    } catch (e: Exception) {
      return null
    }
  }

  private fun getAllManifestValues(): Map<String, Any> {
    val result = mutableMapOf<String, Any>()

    try {
      val appInfo = context.packageManager.getApplicationInfo(
        context.packageName,
        PackageManager.GET_META_DATA
      )

      // Get app label (name)
      val appName = context.packageManager.getApplicationLabel(appInfo).toString()
      result["app_name"] = appName

      // Get package name
      result["package_name"] = context.packageName

      // Get version information
      val packageInfo = context.packageManager.getPackageInfo(context.packageName, 0)
      result["version_name"] = packageInfo.versionName.toString()
      result["version_code"] = packageInfo.versionCode.toString()

      // Get metadata from manifest
      if (appInfo.metaData != null) {
        for (key in appInfo.metaData.keySet()) {
          appInfo.metaData.get(key)?.let {
            result[key] = it
          }
        }
      }
    } catch (e: Exception) {
      // Ignore exceptions
    }

    return result
  }
}
