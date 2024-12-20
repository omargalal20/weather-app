package com.weatherapp.backend.app.presentation.web.v1.controller

import com.weatherapp.backend.app.business.service.WeatherService
import com.weatherapp.backend.app.presentation.web.v1.mapper.WeatherMapper
import com.weatherapp.backend.app.presentation.web.v1.model.response.ForecastResponse
import com.weatherapp.backend.app.presentation.web.v1.model.response.WeatherResponse
import io.github.oshai.kotlinlogging.KotlinLogging
import org.springframework.http.HttpStatus
import org.springframework.http.MediaType
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.CrossOrigin
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RequestParam
import org.springframework.web.bind.annotation.RestController

private val log = KotlinLogging.logger {}

@RestController
@RequestMapping("api/v1/weathers")
@CrossOrigin(origins = ["*"])
class WeatherController(
    private val weatherService: WeatherService,
    private val weatherMapper: WeatherMapper,
) {
    @GetMapping(
        path = [""],
        produces = [MediaType.APPLICATION_JSON_VALUE],
    )
    fun getCurrentWeather(
        @RequestParam("latitude") latitude: Float,
        @RequestParam("longitude") longitude: Float,
    ): ResponseEntity<WeatherResponse> {
        log.info { "getCurrent, WeatherController, latitude: $latitude, longitude: $longitude" }

        val currentWeather = weatherService.getCurrentWeather(latitude, longitude)
        val response = weatherMapper.toWeatherResponse(currentWeather)

        return ResponseEntity
            .status(HttpStatus.OK)
            .body(response)
    }

    @GetMapping(
        path = ["/forecast"],
        produces = [MediaType.APPLICATION_JSON_VALUE],
    )
    fun getForecastedWeather(
        @RequestParam("latitude") latitude: Float,
        @RequestParam("longitude") longitude: Float,
    ): ResponseEntity<ForecastResponse> {
        log.info { "getCurrent, WeatherController, latitude: $latitude, longitude: $longitude" }

        val currentWeather = weatherService.getForecastedWeather(latitude, longitude)
        val response = weatherMapper.toForecastResponse(currentWeather)

        return ResponseEntity
            .status(HttpStatus.OK)
            .body(response)
    }
}
