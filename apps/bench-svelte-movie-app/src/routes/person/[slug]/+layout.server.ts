import type { MovieDisplay } from '@/types/movie';
import type { PersonDetails } from '../../../types/person';
import type { LayoutServerLoad } from './$types';

type CreditsResponse = MovieDisplay & {
	popularity: number;
	vote_count: number;
	media_type: string;
};

export const load: LayoutServerLoad = async ({
	params,
	fetch
}): Promise<{ details: PersonDetails; credits: MovieDisplay[] }> => {
	const personDetails = await fetch(
		`https://api.themoviedb.org/3/person/${params.slug}?api_key=061b5b5397826fffc37bcaad1cc6814f`
	);

	const combinedCredits = await fetch(
		`https://api.themoviedb.org/3/person/${params.slug}/combined_credits?api_key=061b5b5397826fffc37bcaad1cc6814f`
	);
	const {
		cast,
		crew
	}: {
		cast: CreditsResponse[];
		crew: CreditsResponse[];
	} = await combinedCredits.json();
	const allCredits = [...cast, ...crew]
		.filter((credit) => credit.media_type === 'movie')
		.sort((a, b) => b.vote_count - a.vote_count);

	return {
		details: await personDetails.json(),
		credits: allCredits.filter(
			(credit, index) => allCredits.findIndex((other) => other.id === credit.id) === index
		)
	};
};
