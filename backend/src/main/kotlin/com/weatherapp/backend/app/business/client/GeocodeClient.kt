package com.weatherapp.backend.app.business.client

import com.weatherapp.backend.app.business.client.model.response.GeocodeResponse
import org.springframework.cloud.openfeign.FeignClient
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestParam

@FeignClient(
    name = "geocode",
)
interface GeocodeClient {
    @GetMapping("/direct")
    fun getCities(
        @RequestParam q: String,
        @RequestParam limit: Int,
        @RequestParam("appid") appId: String,
    ): List<GeocodeResponse>
}
