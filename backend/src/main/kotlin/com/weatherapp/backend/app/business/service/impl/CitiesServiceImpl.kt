package com.weatherapp.backend.app.business.service.impl

import com.weatherapp.backend.app.business.client.GeocodeClient
import com.weatherapp.backend.app.business.client.model.response.GeocodeResponse
import com.weatherapp.backend.app.business.service.CitiesService
import com.weatherapp.backend.framework.config.WeatherClientConfig
import io.github.oshai.kotlinlogging.KotlinLogging
import org.springframework.stereotype.Service

private val log = KotlinLogging.logger {}
private const val LIMIT = 5

@Service
class CitiesServiceImpl(
    private val geocodeClient: GeocodeClient,
    private val weatherClientConfig: WeatherClientConfig,
) : CitiesService {
    override fun getMany(city: String): List<GeocodeResponse> {
        log.info { "getMany, CitiesServiceImpl: $city" }

        val response = geocodeClient.getCities(city, LIMIT, weatherClientConfig.weatherApiKey)

        return response
    }
}
