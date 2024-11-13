package com.weatherapp.backend.app.presentation.web.v1.model.response

data class WeatherResponse(
    val id: Int,
    val name: String,
    val coord: Coord,
    val weather: List<Weather>,
    val main: Main,
) {
    data class Coord(
        val lon: Double,
        val lat: Double,
    )

    data class Weather(
        val id: Int,
        val main: String,
        val description: String,
        val icon: String,
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
}
