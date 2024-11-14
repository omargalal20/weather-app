const BASE_URL = process.env.REACT_APP_BACKEND_URL;

export const fetchWeatherData = async (city: string | { lat: number; lng: number }) => {
  console.log(`fetchWeatherData, city: ${JSON.stringify(city)}`)

  let url = `${BASE_URL}/weathers?city=${city}`;

  if (typeof city === 'object') {
    url = `${BASE_URL}/weathers?latitude=${city.lat}&longitude=${city.lng}`;
  }
  return await (await fetch(url)).json();
};

export const fetchExtendedForecastData = async (city: string | { lat: number; lng: number }) => {
  console.log(`fetchWeatherData, city: ${JSON.stringify(city)}`)

  let url = `${BASE_URL}/weathers/forecast?city=${city}`;

  if (typeof city === 'object') {
    url = `${BASE_URL}/weathers/forecast?latitude=${city.lat}&longitude=${city.lng}`;
  }

  return await (await fetch(url)).json();
};

