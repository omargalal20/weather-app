package com.weatherapp.backend.app.presentation.web.v1.mapper

import com.weatherapp.backend.app.business.client.model.response.CurrentWeatherResponse
import com.weatherapp.backend.app.business.client.model.response.ForecastWeatherResponse
import com.weatherapp.backend.app.presentation.web.v1.model.response.ForecastResponse
import com.weatherapp.backend.app.presentation.web.v1.model.response.WeatherResponse
import org.mapstruct.Mapper

@Mapper(componentModel = "spring")
interface WeatherMapper {
    fun toWeatherResponse(currentWeatherResponse: CurrentWeatherResponse): WeatherResponse

    fun toForecastResponse(forecastWeatherResponse: ForecastWeatherResponse): ForecastResponse
}
