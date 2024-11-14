package com.weatherapp.backend.app.presentation.web.v1.controller

import com.weatherapp.backend.app.business.client.model.response.GeocodeResponse
import com.weatherapp.backend.app.business.service.CitiesService
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
@RequestMapping("api/v1/cities")
@CrossOrigin(origins = ["*"])
class CityController(
    private val citiesService: CitiesService,
) {
    @GetMapping(
        path = [""],
        produces = [MediaType.APPLICATION_JSON_VALUE],
    )
    fun getMany(
        @RequestParam("city") city: String,
    ): ResponseEntity<List<GeocodeResponse>> {
        log.info { "getCurrent, WeatherController, $city" }

        val response = citiesService.getMany(city)

        return ResponseEntity
            .status(HttpStatus.OK)
            .body(response)
    }
}
