package com.weatherapp.backend.app.presentation.web.v1.controller

import com.weatherapp.backend.app.presentation.web.v1.model.response.WeatherResponse
import io.github.oshai.kotlinlogging.KotlinLogging
import org.springframework.http.HttpStatus
import org.springframework.http.MediaType
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.CrossOrigin
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

private val log = KotlinLogging.logger {}

@RestController
@RequestMapping("api/v1/weathers")
@CrossOrigin(origins = ["*"])
class WeatherController {
    @GetMapping(
        path = ["{city}"],
        produces = [MediaType.APPLICATION_JSON_VALUE],
    )
    fun getOne(
        @PathVariable("city") city: String,
    ): ResponseEntity<WeatherResponse> {
        log.debug { "getOne, WeatherController, city : $city" }

        val response = WeatherResponse(city)
        return ResponseEntity
            .status(HttpStatus.OK)
            .body(response)
    }
}
