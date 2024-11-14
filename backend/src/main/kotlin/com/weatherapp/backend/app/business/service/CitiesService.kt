package com.weatherapp.backend.app.business.service

import com.weatherapp.backend.app.business.client.model.response.GeocodeResponse

interface CitiesService {
    fun getMany(city: String): List<GeocodeResponse>
}
