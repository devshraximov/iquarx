package com.iquarix.app

import io.flutter.embedding.android.FlutterActivity
import com.yandex.mapkit.MapKitFactory

class MainActivity : FlutterActivity() {
    init {
        MapKitFactory.setApiKey("aed11bab-995d-4af2-bf68-ecdc4a115642") // Your generated API key
    }
}