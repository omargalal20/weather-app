package com.weatherapp.backend.app.business.service.impl

import com.weatherapp.backend.app.business.service.WeatherService
import io.github.oshai.kotlinlogging.KotlinLogging
import org.springframework.stereotype.Service

private val log = KotlinLogging.logger {}

@Service
class WeatherServiceImpl : WeatherService
