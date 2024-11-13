package com.weatherapp.backend.framework.config

import org.springframework.beans.factory.annotation.Value
import org.springframework.context.annotation.Configuration

@Configuration
class WeatherClientConfig {
    @Value("\${WEATHER_APIKEY}")
    lateinit var weatherApiKey: String
}
