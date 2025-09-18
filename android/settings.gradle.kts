// android/settings.gradle.kts
pluginManagement {
    val localPropsFile = java.io.File(rootDir, "local.properties")
    val props = java.util.Properties()
    if (localPropsFile.exists()) {
        localPropsFile.inputStream().use { props.load(it) }
    }
    val flutterSdk: String = props.getProperty("flutter.sdk")
        ?: throw GradleException("flutter.sdk not set in local.properties")

    // Necesario para que Gradle encuentre el loader de Flutter
    includeBuild("$flutterSdk/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

// 👇 AQUI declaramos versiones de plugins (muy importante)
plugins {
    id("com.android.application") version "8.3.1" apply false
    id("org.jetbrains.kotlin.android") version "1.9.22" apply false
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
}

include(":app")
