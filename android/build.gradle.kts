allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

// Обход несовместимости: некоторые плагины (sentry_flutter) задают Kotlin
// language version 1.6, который тулчейн Flutter 3.44 (Kotlin 2.x) уже не
// поддерживает. Принудительно поднимаем до 2.0 для всех подпроектов.
// projectsEvaluated — после оценки всех проектов (afterEvaluate нельзя:
// evaluationDependsOn(":app") уже оценил подпроекты).
gradle.projectsEvaluated {
    subprojects {
        // Плагины-модули (sentry_flutter и др.) собираются против compileSdk 34
        // по дефолту Flutter; package_info_plus требует ≥ 36. Форсим для всех.
        extensions.findByType(com.android.build.gradle.BaseExtension::class.java)
            ?.compileSdkVersion(36)
        tasks.withType<org.jetbrains.kotlin.gradle.tasks.KotlinCompile>().configureEach {
            compilerOptions {
                languageVersion.set(org.jetbrains.kotlin.gradle.dsl.KotlinVersion.KOTLIN_2_0)
                apiVersion.set(org.jetbrains.kotlin.gradle.dsl.KotlinVersion.KOTLIN_2_0)
            }
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
