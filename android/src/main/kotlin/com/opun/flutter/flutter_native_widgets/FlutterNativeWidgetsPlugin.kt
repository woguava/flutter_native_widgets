package com.opun.flutter.flutter_native_widgets

import android.annotation.TargetApi
import android.app.Activity
import android.app.AlertDialog
import android.graphics.Color
import android.graphics.drawable.ColorDrawable
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar


class FlutterNativeWidgetsPlugin(val activity: Activity) : MethodCallHandler {
  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val channel = MethodChannel(registrar.messenger(), "flutter_native_widgets")
      channel.setMethodCallHandler(FlutterNativeWidgetsPlugin(registrar.activity()))
    }
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    }else if (call.method == "showConfirmDialog") {
      showConfirmDialog(call,result)
    } else {
      result.notImplemented()
    }
  }

  @TargetApi(11)
  fun showConfirmDialog(call: MethodCall,result: Result){
    val titleStr : String  ?= call.argument<String>("title")
    val messageStr : String ?= call.argument<String>("message")
    val positiveButtonTextStr : String ?= call.argument<String>("positiveButtonText")
    val negativeButtonTextStr : String ?= call.argument<String>("negativeButtonText")
    val positiveButtonTextColorInt : Long ?= call.argument<Long>("positiveButtonTextColor")
    val negativeButtonTextColorInt : Long ?= call.argument<Long>("negativeButtonTextColor")

    println("titleStr :" + titleStr)
    println("messageStr :" + messageStr)
    println("positiveButtonTextStr :" + positiveButtonTextStr)
    println("negativeButtonTextStr :" + negativeButtonTextStr)
    println("positiveButtonTextColorInt :" + positiveButtonTextColorInt?.toInt())
    println("negativeButtonTextColorInt :" + negativeButtonTextColorInt?.toInt())

    val styleId = activity.getResources().getIdentifier("OUDialogStyle","style",activity.packageName)
    val builder = AlertDialog.Builder(activity,styleId)
            .setCancelable(false)

    if(! titleStr.isNullOrEmpty()){
        builder.setTitle(titleStr)
    }
    if(! messageStr.isNullOrEmpty()){
        builder.setMessage(messageStr)
    }

    if(! positiveButtonTextStr.isNullOrEmpty()){
      builder.setPositiveButton(positiveButtonTextStr, { _,_ -> result.success(true)})
    }

    if(! negativeButtonTextStr.isNullOrEmpty()){
      builder.setNegativeButton(negativeButtonTextStr, { _,_ -> result.success(false)})
    }

    val confirmDialog = builder.create();
    confirmDialog.show()

    val dm = activity.getResources().getDisplayMetrics()
    val displayWidth = dm.widthPixels
    val displayHeight = dm.heightPixels
    val p = confirmDialog.window.attributes
    p.width = (displayWidth * 0.8).toInt()
    //p.height = (displayHeight * 0.28).toInt()
    confirmDialog.window.attributes = p
    confirmDialog.window.setBackgroundDrawable( ColorDrawable(Color.TRANSPARENT) )

    //if(! positiveButtonTextColorInt.isNullOrBlank())
    if(positiveButtonTextColorInt != null)
      confirmDialog.getButton(AlertDialog.BUTTON_POSITIVE).setTextColor(positiveButtonTextColorInt.toInt())
    //if (! negativeButtonTextColorInt.isNullOrBlank())
    if(negativeButtonTextColorInt != null)
      confirmDialog.getButton(AlertDialog.BUTTON_NEGATIVE).setTextColor(negativeButtonTextColorInt.toInt())

  }
}
