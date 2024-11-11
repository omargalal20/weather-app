plugins {
    val springBootVersion = "3.3.5"
    val dependencyManagementVersion = "1.1.6"
    val kotlinVersion = "1.9.25"
    val jibVersion = "3.4.4"
    val hibernateMavenVersion = "3.0.4"
    val flyWayVersion = "9.19.0"
    val detektVersion = "1.23.3"
    val ktlintVersion = "12.1.1"

    id("org.springframework.boot") version springBootVersion
    id("io.spring.dependency-management") version dependencyManagementVersion
    id("maven-publish")
    id("org.hibernate.build.maven-repo-auth") version hibernateMavenVersion
    id("com.google.cloud.tools.jib") version jibVersion
    id("org.flywaydb.flyway") version flyWayVersion
    id("io.gitlab.arturbosch.detekt") version detektVersion
    id("org.jlleitschuh.gradle.ktlint") version ktlintVersion

    kotlin("jvm") version kotlinVersion
    kotlin("plugin.spring") version kotlinVersion
    kotlin("plugin.jpa") version kotlinVersion
    kotlin("kapt") version kotlinVersion
}

group = "com.weatherapp"
version = "0.0.1"

java {
    toolchain {
        languageVersion = JavaLanguageVersion.of(21)
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
    val queryDslVersion = "5.0.0"
    val mapstructVersion = "1.4.2.Final"
    val flyWayVersion = "9.19.0"
    val kotlinLoggingVersion = "5.0.1"
    val swaggerVersion = "2.6.0"
    val detektFormatterVersion = "1.23.3"

    implementation("org.springframework.boot:spring-boot-starter-data-jpa")
    implementation("org.springframework.boot:spring-boot-starter-web")
    implementation("org.jetbrains.kotlin:kotlin-reflect")
    implementation("org.springframework.boot:spring-boot-starter-validation")
    implementation("org.springframework.cloud:spring-cloud-starter-openfeign:4.1.3")

    implementation("com.fasterxml.jackson.module:jackson-module-kotlin")
    implementation("io.github.oshai:kotlin-logging-jvm:$kotlinLoggingVersion")
    implementation("org.jetbrains.kotlin:kotlin-reflect")
    implementation("org.springdoc:springdoc-openapi-starter-webmvc-ui:$swaggerVersion")

    implementation("com.querydsl:querydsl-core:$queryDslVersion")
    implementation("com.querydsl:querydsl-jpa:$queryDslVersion:jakarta")
    implementation("org.mapstruct:mapstruct:$mapstructVersion")
    implementation("org.flywaydb:flyway-core:$flyWayVersion")

    compileOnly("org.projectlombok:lombok")
    developmentOnly("org.springframework.boot:spring-boot-devtools")
    runtimeOnly("org.postgresql:postgresql")

    annotationProcessor("org.projectlombok:lombok")
    annotationProcessor("org.mapstruct:mapstruct-processor:$mapstructVersion")
    annotationProcessor("com.querydsl:querydsl-apt:$queryDslVersion:jakarta")

    kapt("com.querydsl:querydsl-apt:$queryDslVersion:jakarta")
    kapt("org.mapstruct:mapstruct-processor:$mapstructVersion")

    detektPlugins("io.gitlab.arturbosch.detekt:detekt-formatting:$detektFormatterVersion")

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
        arg("plugin", "com.querydsl.apt.jpa.JPAAnnotationProcessor")
        arg("kapt.include.compile.classpath", "false")
    }
}

jib.to.setCredHelper("ecr-login")

jib {
    from {
        image = "openjdk:17-alpine"
    }
    container {
        ports = listOf<String>("8553")
    }
}

tasks.withType<Test> {
    useJUnitPlatform()
}
