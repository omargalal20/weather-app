plugins {
    val springBootVersion = "3.3.5"
    val dependencyManagementVersion = "1.1.6"
    val kotlinVersion = "1.9.25"
    val jibVersion = "3.4.4"

    id("org.springframework.boot") version springBootVersion
    id("io.spring.dependency-management") version dependencyManagementVersion
    id("maven-publish")
    id("com.google.cloud.tools.jib") version jibVersion

    kotlin("jvm") version kotlinVersion
    kotlin("plugin.spring") version kotlinVersion
    kotlin("kapt") version kotlinVersion
}

group = "com.weatherapp"
version = "1.0.1"

java {
    toolchain {
        val javaVersion =
            if (System.getenv("CI") == "true") {
                JavaLanguageVersion.of(17)
            } else {
                JavaLanguageVersion.of(21)
            }
        languageVersion.set(javaVersion)
    }
}

configurations {
    compileOnly {
        extendsFrom(configurations.annotationProcessor.get())
    }
}

repositories {
    mavenCentral()
}

dependencies {
    val mapstructVersion = "1.6.3"
    val kotlinLoggingVersion = "5.0.1"
    val swaggerVersion = "2.6.0"
    val openFeignVersion = "4.1.3"

    implementation("org.springframework.boot:spring-boot-starter-web")
    implementation("org.jetbrains.kotlin:kotlin-reflect")
    implementation("org.springframework.boot:spring-boot-starter-validation")
    implementation("org.springframework.cloud:spring-cloud-starter-openfeign:$openFeignVersion")

    implementation("com.fasterxml.jackson.module:jackson-module-kotlin")
    implementation("io.github.oshai:kotlin-logging-jvm:$kotlinLoggingVersion")
    implementation("org.jetbrains.kotlin:kotlin-reflect")
    implementation("org.springdoc:springdoc-openapi-starter-webmvc-ui:$swaggerVersion")

    implementation("org.mapstruct:mapstruct:$mapstructVersion")

    compileOnly("org.projectlombok:lombok")
    developmentOnly("org.springframework.boot:spring-boot-devtools")

    annotationProcessor("org.projectlombok:lombok")
    annotationProcessor("org.mapstruct:mapstruct-processor:$mapstructVersion")

    kapt("org.mapstruct:mapstruct-processor:$mapstructVersion")

    testImplementation("org.springframework.boot:spring-boot-starter-test")
    testImplementation("org.jetbrains.kotlin:kotlin-test-junit5")

    testRuntimeOnly("org.junit.platform:junit-platform-launcher")
}

kotlin {
    compilerOptions {
        freeCompilerArgs.addAll("-Xjsr305=strict")
    }
}

allOpen {
    annotation("jakarta.persistence.Entity")
    annotation("jakarta.persistence.MappedSuperclass")
    annotation("jakarta.persistence.Embeddable")
}

kapt {
    javacOptions {
        option("querydsl.entityAccessors", true)
    }
    arguments {
        arg("kapt.kotlin.generated", file("build/generated/source/kapt/main"))
        arg("kapt.include.compile.classpath", "false")
    }
}

jib.to.setCredHelper("ecr-login")

jib {
    from {
        image = "eclipse-temurin:21-jdk-alpine"
    }
    container {
        ports = listOf<String>("8553")
    }
}

tasks.withType<Test> {
    useJUnitPlatform()
}
