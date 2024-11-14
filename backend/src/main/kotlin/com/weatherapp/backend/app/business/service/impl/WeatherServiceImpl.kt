package com.weatherapp.backend.app.business.service.impl

import com.weatherapp.backend.app.business.client.WeatherClient
import com.weatherapp.backend.app.business.client.model.response.CurrentWeatherResponse
import com.weatherapp.backend.app.business.client.model.response.ForecastWeatherResponse
import com.weatherapp.backend.app.business.service.WeatherService
import com.weatherapp.backend.framework.config.WeatherClientConfig
import io.github.oshai.kotlinlogging.KotlinLogging
import org.springframework.stereotype.Service

private val log = KotlinLogging.logger {}

@Service
class WeatherServiceImpl(
    private val weatherClient: WeatherClient,
    private val weatherClientConfig: WeatherClientConfig,
) : WeatherService {
    companion object {
        private const val FORECASTED_DAYS_COUNT = 7
    }

    override fun getCurrentWeather(city: String): CurrentWeatherResponse {
        log.info { "getCurrentWeather, WeatherServiceImpl: $city" }

        val response = weatherClient.getCurrent(city, weatherClientConfig.weatherApiKey)

        return response
    }

    override fun getForecastedWeather(city: String): ForecastWeatherResponse {
        log.info { "getForecastedWeather, WeatherServiceImpl: $city" }

        val response = weatherClient.getForecast(city, FORECASTED_DAYS_COUNT, weatherClientConfig.weatherApiKey)

        return response
    }
}
