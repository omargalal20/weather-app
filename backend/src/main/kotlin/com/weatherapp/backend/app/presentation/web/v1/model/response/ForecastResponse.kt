package com.weatherapp.backend.app.presentation.web.v1.model.response

import java.time.LocalDateTime

data class ForecastResponse(
    val cod: String,
    val message: Int,
    val cnt: Int,
    val list: List<ForecastEntry>,
    val city: City,
) {
    data class ForecastEntry(
        val dt: Long,
        val main: Main,
        val weather: List<Weather>,
        val wind: Wind,
        val pop: Double,
        val dateTime: LocalDateTime,
    )

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
