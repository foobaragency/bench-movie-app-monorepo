import type { MovieDetails, MovieDisplay } from '../../../types/movie';
import type { LayoutServerLoad } from './$types';

export const load: LayoutServerLoad = async ({ params, fetch }): Promise<MovieDetails> => {
	const movieDetails = await fetch(
		`https://api.themoviedb.org/3/movie/${params.slug}?api_key=061b5b5397826fffc37bcaad1cc6814f`
	);

	const similarMovies = await fetch(
		`https://api.themoviedb.org/3/movie/${params.slug}/similar?api_key=061b5b5397826fffc37bcaad1cc6814f`
	);
	const similar: { results: (MovieDisplay & { popularity: number; vote_count: number })[] } =
		await similarMovies.json();

	const credits = await fetch(
		`https://api.themoviedb.org/3/movie/${params.slug}/credits?api_key=061b5b5397826fffc37bcaad1cc6814f`
	);

	return {
		movie: await movieDetails.json(),
		credits: await credits.json(),
		similar: similar.results.sort((a, b) => b.vote_count - a.vote_count)
	};
};
