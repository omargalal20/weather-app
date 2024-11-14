import { CitySuggestionData } from "./types";

const BASE_URL = process.env.REACT_APP_BACKEND_URL;

export const fetchCities = async (search: string) => {
  const url = `${BASE_URL}/cities?city=${search}`;
  const response = await (
    await fetch(url)
  ).json();

  console.log(response)

  return response
    .map((city: CitySuggestionData) => {
      return city.name + ', ' + (city.state || city.country);
    });
};
