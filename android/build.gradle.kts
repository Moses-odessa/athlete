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
// compileSdk 36 для всех модулей: задаём в момент применения Android-плагина
// (до того как AGP его прочитает — иначе «too late to set compileSdk»).
// Нужно, т.к. плагины (sentry_flutter) по дефолту Flutter собираются против 34,
// а package_info_plus требует ≥ 36.
subprojects {
    plugins.withType<com.android.build.gradle.BasePlugin>().configureEach {
        extensions.getByType(com.android.build.gradle.BaseExtension::class.java)
            .compileSdkVersion(36)
    }
}

// Kotlin 2.0 для всех подпроектов (перекрывает 1.6 из sentry_flutter).
// В projectsEvaluated — чтобы override применился последним.
gradle.projectsEvaluated {
    subprojects {
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
