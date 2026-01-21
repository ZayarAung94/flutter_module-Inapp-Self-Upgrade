# In-App Self Upgrade Module 🚀

ဒီ Module ကို အခြား Project တွေမှာ အလွယ်တကူ ပြန်သုံးနိုင်ဖို့ အောက်ပါ Setup အဆင့်ဆင့်ကို လုပ်ဆောင်ပေးရပါမယ်။

---

## 1. Module Installation
ဒီ Module ကို သင့် Project မှာ အသုံးပြုဖို့ အတွက် `terminal` မှာ အောက်ပါ command ကို ရိုက်ထည့်ပါ-

```bash
gti submodule add https://github.com/ZayarAung94/flutter_module-Inapp-Self-Upgrade.git lib/modules/inapp_self_upgrade
```

## 2. Dependency Injection (GetX)

`Initial Binding` (သို့) `main.dart` ဖိုင်ထဲမှာ အောက်ပါ code ကို ထည့်ပေးပါ-

```dart
// Repositories
Get.lazyPut<VersionInfoRepository>(() => VersionInfoRepoInpl(), fenix: true);
Get.lazyPut(() => ApkInstallService(), fenix: true);
Get.lazyPut(() => AppVersionsFacade(), fenix: true);
```


## 3. Android Native Setup (Critical)

ဒီ Module က Native APK Installation ကို အသုံးပြုထားတဲ့အတွက် `android` folder အောက်မှာ အောက်ပါတို့ကို ပြင်ဆင်ပေးပါ။

### A. AndroidManifest.xml
`<application>` tag အပိတ်နားမှာ `FileProvider` ကို ထည့်ပေးပါ-

```xml
<provider
    android:name="androidx.core.content.FileProvider"
    android:authorities="${applicationId}.fileprovider"
    android:exported="false"
    android:grantUriPermissions="true">
    <meta-data
        android:name="android.support.FILE_PROVIDER_PATHS"
        android:resource="@xml/provider_paths" />
</provider>
```

### B. provider_paths.xml
`res/xml/` folder ထဲမှာ `provider_paths.xml` ဖိုင်ကို ဖန်တီးပေးပါ-
```xml
<?xml version="1.0" encoding="utf-8"?>
<paths xmlns:android="http://schemas.android.com/apk/res/android">
    <external-path name="external_files" path="." />
</paths>
``` 

### C. MainActivity.kt
`MainActivity.kt` ဖိုင်ထဲမှာ အောက်ပါ code ကို ထည့်ပေးပါ-
```kotlin
// မိမိ App ၏ Package Name သို့ ပြောင်းရန်

//import android.content.Intent
//import android.net.Uri
//import android.os.Build
//import androidx.core.content.FileProvider
//import io.flutter.embedding.android.FlutterActivity
//import io.flutter.embedding.engine.FlutterEngine
//import io.flutter.plugin.common.MethodChannel
//import java.io.File

class MainActivity : FlutterActivity() {

    private val INSTALL_CHANNEL = "com.taximeter/install"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, INSTALL_CHANNEL)
            .setMethodCallHandler { call, result ->
                if (call.method == "installApk") {
                    val filePath = call.argument<String>("filePath")
                    if (filePath != null) {
                        try {
                            val file = File(filePath)
                            val uri = FileProvider.getUriForFile(
                                this, 
                                "${context.packageName}.fileprovider", 
                                file
                            )
                            
                            val intent = Intent(Intent.ACTION_VIEW)
                            intent.setDataAndType(uri, "application/vnd.android.package-archive")
                            intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
                            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                            
                            startActivity(intent)
                            result.success(true)
                        } catch (e: Exception) {
                            result.error("INSTALL_ERROR", e.message, null)
                        }
                    } else {
                        result.error("INVALID_PATH", "File path is null", null)
                    }
                } else {
                    result.notImplemented()
                }
            }
    }
}
```
    


