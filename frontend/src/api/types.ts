// types.ts

// Type definitions for the Weather API response
export interface Coord {
  lon: number;
  lat: number;
}

export interface WeatherDescription {
  id: number;
  main: string;
  description: string;
  icon: string;
}

export interface MainWeatherData {
  temp: number;
  feelsLike: number;
  tempMin: number;
  tempMax: number;
  pressure: number;
  humidity: number;
  seaLevel?: number;  // seaLevel is optional as it may not be present in every response
  grndLevel?: number; // grndLevel is optional for the same reason
}

export interface Sys {
  country: String;
  sunrise: number;
  sunset: number
}

// Main object for current weather data
export interface WeatherData {
  cod: number;
  id: number;
  name: string;
  coord: Coord;
  weather: WeatherDescription[];
  main: MainWeatherData;
  wind: Wind;
  sys: Sys
}

// Type definitions for the Forecast API response
export interface ForecastMainData extends MainWeatherData { } // Reuse MainWeatherData structure

export interface Wind {
  speed: number;
  deg: number;
  gust?: number; // gust is optional
}

export interface ForecastListItem {
  dt: number;
  main: ForecastMainData;
  weather: WeatherDescription[];
  wind: Wind;
  pop: number;
  dateTime: string;
}

export interface City {
  id: number;
  name: string;
  coord: Coord;
  country: string;
  population: number;
  timezone: number;
  sunrise: number;
  sunset: number;
}

export type ExtendedForecastData = {
  day: string;
  temp: {
    tempMin: number;
    tempMax: number;
  };
  weather: {
    id: number;
    main: string;
  };
}

export interface CitySuggestionData {
  name: String;
  lat: number;
  lon: number;
  country: String;
  state: String | undefined;
}