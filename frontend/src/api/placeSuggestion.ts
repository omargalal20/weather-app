import { CitySuggestionData } from "./types";

const BASE_URL = process.env.REACT_APP_BACKEND_URL;

export const fetchCities = async (search: string) => {
  const url = `${BASE_URL}/cities?city=${search}`;
  const response = await (
    await fetch(url)
  ).json();

  return response
    .map((city: CitySuggestionData) => {
      return city
    });
};
