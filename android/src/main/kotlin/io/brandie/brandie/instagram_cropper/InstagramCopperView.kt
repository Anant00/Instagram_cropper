package io.brandie.brandie.instagram_cropper

import android.content.Context
import android.net.Uri
import androidx.core.content.ContextCompat
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.platform.PlatformView
import java.io.File

class InstagramCopperView
internal constructor(private val context: Context, id: Int, messenger: BinaryMessenger): PlatformView, MethodChannel.MethodCallHandler {
    private var view: InstagramLikeCropperView = InstagramLikeCropperView(context)
    private val methodChannel: MethodChannel = MethodChannel(messenger, "plugins/instagram_cropper_$id")

    init {
        methodChannel.setMethodCallHandler(this)
    }
    override fun getView() = view

    override fun dispose() {
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when(call.method) {
            "getView" -> getView(call, result)
            "setUri" -> setUri(call, result)
            "crop" -> startCropping();
            else -> result.notImplemented()
        }
    }

    private fun getView(methodCall: MethodCall ,result: Result) {
        val isDarkTheme = methodCall.arguments as Boolean
        val color = if (isDarkTheme) R.color.colorBlack else R.color.colorWhite
        view.setBackgroundColor(ContextCompat.getColor(context, color))
        result.success(null)
    }

    private fun setUri(methodCall: MethodCall, result: Result) {
        val uri = Uri.fromFile(File(methodCall.argument<String>("imageUri")!!))
        val imageName = methodCall.argument<String>("imageName")
        view.setImageUri(uri, imageName)
        result.success(null)
    }

    private fun startCropping() {

    }
}