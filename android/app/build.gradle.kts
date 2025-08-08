import java.util.Properties
import java.io.FileInputStream
import java.io.FileNotFoundException

plugins {
    id("com.android.application")
    id("kotlin-android")
    id("com.google.gms.google-services")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

fun loadKeystoreProperties(filePath: String): Properties {
    val keystoreProperties = Properties()
    val keystoreFile = File(filePath)
    if (keystoreFile.exists()) {
        FileInputStream(keystoreFile).use { keystoreProperties.load(it) }
    } else {
        throw FileNotFoundException("Keystore properties file not found at path: $filePath")
    }
    return keystoreProperties
}

val localProperties = Properties()
val localPropertiesFile = rootProject.file("local.properties")
if (localPropertiesFile.exists()) {
    FileInputStream(localPropertiesFile).use { localProperties.load(it) }
}
val flutterVersionName = localProperties.getProperty("flutter.versionName") ?: "1.0"

android {
    compileSdk = 35
    ndkVersion = "27.0.12077973"
    // ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = 23
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        multiDexEnabled = true
    }

    signingConfigs {
        create("cendana") {
            val keystoreProperties = loadKeystoreProperties("${rootProject.projectDir}/app/src/cendana/key.properties")
            keyAlias = keystoreProperties["keyAlias"] as String
            keyPassword = keystoreProperties["keyPassword"] as String
            storeFile = keystoreProperties["storeFile"]?.let { 
                File("${rootProject.projectDir}/app/src/cendana/$it")
            }
            storePassword = keystoreProperties["storePassword"] as String
        }

        create("premagana") {
            val keystoreProperties = loadKeystoreProperties("${rootProject.projectDir}/app/src/premagana/key.properties")
            keyAlias = keystoreProperties["keyAlias"] as String
            keyPassword = keystoreProperties["keyPassword"] as String
            storeFile = keystoreProperties["storeFile"]?.let { 
                File("${rootProject.projectDir}/app/src/premagana/$it")
            }
            storePassword = keystoreProperties["storePassword"] as String
        }

        getByName("debug") {
            keyAlias = "AndroidDebugKey"
            keyPassword = "android"
            storeFile = file("debug.keystore")
            storePassword = "android"
        }
    }

    flavorDimensions("app")
    productFlavors {
        create("cendana") {
            dimension = "app"
            resValue("string", "app_name", "HaiMed RS Cendana")
            namespace = "com.sanata.haimed.cendana"
            applicationId = "com.sanata.haimed.cendana"
            versionName = flutterVersionName
            // signingConfig = signingConfigs.getByName("cendana")
            //uncomment signingconfig above and comment signingconfig below for release per flavor
            signingConfig = signingConfigs.getByName("debug")
        }

        create("rsbk") {
            dimension = "app"
            resValue("string", "app_name", "SIPRAJA RS Bhayangkara Denpasar")
            namespace = "com.haimed.rsbk"
            applicationId = "com.haimed.rsbk"
            versionName = flutterVersionName
            // signingConfig = signingConfigs.getByName("rsbk")
            //uncomment signingconfig above and comment signingconfig below for release per flavor
            signingConfig = signingConfigs.getByName("debug")
        }

        create("rsbkdev") {
            dimension = "app"
            resValue("string", "app_name", "Dev SIPRAJA")
            namespace = "com.sanata.haimed.rsbk.dev"
            applicationId = "com.sanata.haimed.rsbk.dev"
            versionName = flutterVersionName
            signingConfig = signingConfigs.getByName("debug")
        }

        create("suwiti") {
            dimension = "app"
            resValue("string", "app_name", "HaiMed RSD Suwiti")
            namespace = "com.sanata.haimed.rssuwiti"
            applicationId = "com.sanata.haimed.rssuwiti"
            versionName = flutterVersionName
            // signingConfig = signingConfigs.getByName("suwiti")
            //uncomment signingconfig above and comment signingconfig below for release per flavor
            signingConfig = signingConfigs.getByName("debug")
        }

        create("giriasih") {
            dimension = "app"
            resValue("string", "app_name", "HaiMed RSD Giri Asih")
            namespace = "com.sanata.haimed.rsgiriasih"
            applicationId = "com.sanata.haimed.rsgiriasih"
            versionName = flutterVersionName
            // signingConfig = signingConfigs.getByName("giriasih")
            //uncomment signingconfig above and comment signingconfig below for release per flavor
            signingConfig = signingConfigs.getByName("debug")
        }

        create("premagana") {
            dimension = "app"
            resValue("string", "app_name", "HaiMed RS Premagana")
            namespace = "com.sanata.haimed.premagana"
            applicationId = "com.sanata.haimed.premagana"
            versionName = flutterVersionName
            // signingConfig = signingConfigs.getByName("premagana")
            //uncomment signingconfig above and comment signingconfig below for release per flavor
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    implementation("org.jetbrains.kotlin:kotlin-stdlib:2.1.0")
    implementation(platform("com.google.firebase:firebase-bom:33.1.2"))
    implementation("com.google.firebase:firebase-analytics")
    implementation("com.google.android.material:material:1.12.0")
    implementation("androidx.multidex:multidex:2.0.1")
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.0.4")
    implementation("androidx.window:window:1.2.0")
    implementation("androidx.window:window-java:1.2.0")
}