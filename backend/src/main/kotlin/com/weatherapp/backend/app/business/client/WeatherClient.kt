package com.weatherapp.backend.app.business.client

import com.weatherapp.backend.app.business.client.model.response.CurrentWeatherResponse
import com.weatherapp.backend.app.business.client.model.response.ForecastWeatherResponse
import org.springframework.cloud.openfeign.FeignClient
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestParam

@FeignClient(
    name = "weather",
)
interface WeatherClient {
    @GetMapping("/weather")
    fun getCurrent(
        @RequestParam("lat") latitude: Float,
        @RequestParam("lon") longitude: Float,
        @RequestParam apiKey: String,
    ): CurrentWeatherResponse

    @GetMapping("/forecast")
    fun getForecast(
        @RequestParam("lat") latitude: Float,
        @RequestParam("lon") longitude: Float,
        @RequestParam cnt: Int,
        @RequestParam apiKey: String,
    ): ForecastWeatherResponse
}
