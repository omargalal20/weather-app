package com.weatherapp.backend.app.business.service

import com.weatherapp.backend.app.business.client.model.response.CurrentWeatherResponse
import com.weatherapp.backend.app.business.client.model.response.ForecastWeatherResponse

interface WeatherService {
    fun getCurrentWeather(
        latitude: Float,
        longitude: Float,
    ): CurrentWeatherResponse

    fun getForecastedWeather(
        latitude: Float,
        longitude: Float,
    ): ForecastWeatherResponse
}
