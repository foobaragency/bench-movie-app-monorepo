import type { CastMember, CrewMember } from "./castAndCrew";

export type Movie = {
  backdrop_path: string;
  genres: { id: number; name: string }[];
  id: number;
  overview: string;
  poster_path: string;
  release_date: string;
  runtime: number;
  tagline: string;
  title: string;
};

export type MovieCredits = {
  cast: CastMember[];
  crew: CrewMember[];
};

export type MovieDetails = {
  movie: Movie;
  credits: MovieCredits;
  similar: MovieDisplay[];
};

export type MovieDisplay = {
  id: string;
  title: string;
  poster_path: string;
  release_date: string;
}
