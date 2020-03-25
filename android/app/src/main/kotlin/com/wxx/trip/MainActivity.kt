package com.wxx.trip

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        //SplashScreen.show(this, true);
        GeneratedPluginRegistrant.registerWith(flutterEngine)
    }
}
