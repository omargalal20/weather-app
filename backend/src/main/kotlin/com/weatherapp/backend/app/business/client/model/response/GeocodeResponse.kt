package com.weatherapp.backend.app.business.client.model.response

data class GeocodeResponse(
    val name: String,
    val lat: Double,
    val lon: Double,
    val country: String,
    val state: String?,
)
