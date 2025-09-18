// android/build.gradle.kts  (root del módulo android)

// Repos para todos los subproyectos
allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

/**
 * Workaround para librerías que no declaran `namespace` con AGP 8.x.
 * Aquí detectamos el subproyecto `isar_flutter_libs` y le seteamos
 * el namespace por reflexión (sin importar clases del plugin).
 */
subprojects {
    if (name == "isar_flutter_libs") {
        plugins.withId("com.android.library") {
            // Obtiene la extensión "android" de este subproyecto
            val androidExt = extensions.findByName("android")
            if (androidExt != null) {
                // Busca el método setNamespace(String) por reflexión
                val m = androidExt.javaClass.methods.firstOrNull {
                    it.name == "setNamespace" &&
                    it.parameterTypes.size == 1 &&
                    it.parameterTypes[0] == String::class.java
                }
                // Invoca setNamespace("dev.isar.isar_flutter_libs") si existe
                m?.invoke(androidExt, "dev.isar.isar_flutter_libs")
            }
        }
    }
}

// tarea clean
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
