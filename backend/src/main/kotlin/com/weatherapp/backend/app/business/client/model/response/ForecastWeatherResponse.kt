package com.weatherapp.backend.app.business.client.model.response

import com.fasterxml.jackson.annotation.JsonFormat
import com.fasterxml.jackson.annotation.JsonProperty
import com.fasterxml.jackson.databind.PropertyNamingStrategies
import com.fasterxml.jackson.databind.annotation.JsonNaming
import java.time.LocalDateTime

data class ForecastWeatherResponse(
    val cod: String,
    val message: Int,
    val cnt: Int,
    val list: List<ForecastEntry>,
    val city: City,
) {
    data class ForecastEntry(
        val main: Main,
        val weather: List<Weather>,
        val clouds: Clouds,
        val wind: Wind,
        @JsonProperty("dt_txt")
        @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
        val dateTime: LocalDateTime,
    )

    @JsonNaming(PropertyNamingStrategies.SnakeCaseStrategy::class)
    data class Main(
        val temp: Double,
        val feelsLike: Double,
        val tempMin: Double,
        val tempMax: Double,
        val pressure: Int,
        val humidity: Int,
        val seaLevel: Int?,
        val grndLevel: Int?,
    )

    data class Weather(
        val id: Int,
        val main: String,
        val description: String,
        val icon: String,
    )

    data class Clouds(
        val all: Int,
    )

    data class Wind(
        val speed: Double,
        val deg: Int,
        val gust: Double,
    )

    data class City(
        val id: Int,
        val name: String,
        val coord: Coord,
        val country: String,
        val population: Int,
        val timezone: Int,
        val sunrise: Long,
        val sunset: Long,
    )

    data class Coord(
        val lat: Double,
        val lon: Double,
    )
}
