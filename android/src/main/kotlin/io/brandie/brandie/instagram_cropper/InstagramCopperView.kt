package io.brandie.brandie.instagram_cropper

import android.content.Context
import android.net.Uri
import android.view.LayoutInflater
import android.view.View
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.platform.PlatformView
import java.io.File

class InstagramCopperView
internal constructor(context: Context, id: Int, messenger: BinaryMessenger): PlatformView, MethodChannel.MethodCallHandler {
    private var view: View = LayoutInflater.from(context).inflate(R.layout.insta_crop_view, null)
    private val methodChannel: MethodChannel = MethodChannel(messenger, "plugins/instagram_cropper_$id")
    private lateinit var instaCropperView: InstagramLikeCropperView

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
            else -> result.notImplemented()
        }
    }

    private fun getView(methodCall: MethodCall ,result: Result) {
        instaCropperView = view.findViewById(R.id.instacropper)
        result.success(null)
    }

    private fun setUri(methodCall: MethodCall, result: Result) {
        val uri = Uri.fromFile(File(methodCall.arguments as String))
        println("Image Uri is $uri")
        instaCropperView.setImageUri(uri, "screenshot")
        result.success(null)
    }
}