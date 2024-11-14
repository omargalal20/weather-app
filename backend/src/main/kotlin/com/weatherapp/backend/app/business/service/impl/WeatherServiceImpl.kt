package com.weatherapp.backend.app.business.service.impl

import com.weatherapp.backend.app.business.client.WeatherClient
import com.weatherapp.backend.app.business.client.model.response.CurrentWeatherResponse
import com.weatherapp.backend.app.business.client.model.response.ForecastWeatherResponse
import com.weatherapp.backend.app.business.service.WeatherService
import com.weatherapp.backend.framework.config.WeatherClientConfig
import io.github.oshai.kotlinlogging.KotlinLogging
import org.springframework.stereotype.Service

private val log = KotlinLogging.logger {}
private const val FORECASTED_DAYS_COUNT = 7

@Service
class WeatherServiceImpl(
    private val weatherClient: WeatherClient,
    private val weatherClientConfig: WeatherClientConfig,
) : WeatherService {
    override fun getCurrentWeather(
        latitude: Float,
        longitude: Float,
    ): CurrentWeatherResponse {
        log.info { "getCurrentWeather, WeatherServiceImpl: latitude: $latitude, longitude: $longitude" }

        val response = weatherClient.getCurrent(latitude, longitude, weatherClientConfig.weatherApiKey)

        return response
    }

    override fun getForecastedWeather(
        latitude: Float,
        longitude: Float,
    ): ForecastWeatherResponse {
        log.info { "getForecastedWeather, WeatherServiceImpl: latitude: $latitude, longitude: $longitude" }

        val response =
            weatherClient.getForecast(latitude, longitude, FORECASTED_DAYS_COUNT, weatherClientConfig.weatherApiKey)

        return response
    }
}
