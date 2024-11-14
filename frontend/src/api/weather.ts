const BASE_URL = process.env.REACT_APP_BACKEND_URL;

export const fetchWeatherData = async (city: string | { lat: number; lng: number }) => {
  let url = `${BASE_URL}/weathers?city=${city}`;

  if (typeof city === 'object') {
    url = `${BASE_URL}/weathers?lat=${city.lat}&lon=${city.lng}`;
  }
  return await (await fetch(url)).json();
};

export const fetchExtendedForecastData = async (city: string | { lat: number; lng: number }) => {
  let url = `${BASE_URL}/weathers/forecast?city=${city}`;

  if (typeof city === 'object') {
    url = `${BASE_URL}/weathers/forecast?lat=${city.lat}&lon=${city.lng}`;
  }

  return await (await fetch(url)).json();
};

