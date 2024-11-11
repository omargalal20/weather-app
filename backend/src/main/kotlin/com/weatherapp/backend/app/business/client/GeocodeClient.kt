package com.weatherapp.backend.app.business.client

import org.springframework.cloud.openfeign.FeignClient

@FeignClient(
    name = "geocode",
)
interface GeocodeClient
