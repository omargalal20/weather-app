package com.weatherapp.backend

import org.junit.jupiter.api.Test
import org.springframework.boot.test.context.SpringBootTest

@SpringBootTest(properties = ["spring.profiles.active=test"])
class BackendApplicationTests {
    @Test
    fun contextLoads() {
    }
}
