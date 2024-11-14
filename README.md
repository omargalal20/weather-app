# Weather App

<img src="https://user-images.githubusercontent.com/25284536/90274607-2535a000-de76-11ea-9d21-ab8c3e68b3a9.png" width="400"> <img src="https://user-images.githubusercontent.com/25284536/90274626-29fa5400-de76-11ea-97a7-c6b67ec2f66a.png" width="400">

## Tech Stack

- **Frontend: React, Typescript, Redux, StyledComponents**
- **Backend: Spring Boot**

## Features

- **Weather forecast for any city**
- **Extended 7 days forecast**
- **Find user location weather by utilizing GeolocationAPI**
- **One-click Celcius to Fahrenheit conversion and vice versa**
- **Dark Mode**

## Getting Started

### Backend Setup
First you need an API key from OpenWeatherMap, you can get one by creating an account on their website. After you got your API key, replace WEATHER_APIKEY with your OpenWeatherMap API Key.

```
SERVER_PORT
SPRING_PROFILES_ACTIVE
SPRING_DATASOURCE_PASSWORD
SPRING_DATASOURCE_URL
SPRING_DATASOURCE_USERNAME
WEATHER_APIKEY
SPRING_CLOUD_OPENFEIGN_CLIENT_CONFIG_GEOCODE_URL=http://api.openweathermap.org/geo/1.0
SPRING_CLOUD_OPENFEIGN_CLIENT_CONFIG_WEATHER_URL=https://api.openweathermap.org/data/2.5
```

### Frontend Setup

```
REACT_APP_BACKEND_URL=Backend URL
```

## Credits

- **Frontend was inspired by https://github.com/silent-sea1119/react-weather-app/tree/main**
