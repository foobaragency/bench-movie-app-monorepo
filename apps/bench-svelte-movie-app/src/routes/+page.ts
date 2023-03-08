import type { MovieDisplay } from '@/types/movie';
import type { PageLoad } from './$types';

/** @type {import('./$types').PageLoad} */
export const load: PageLoad = async ({
  fetch
}): Promise<{ popular: MovieDisplay[]; upcoming: MovieDisplay[] }> => {
  const popularResponse = await fetch(
    'https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=061b5b5397826fffc37bcaad1cc6814f'
  );

  const upcomingResponse = await fetch(
    'https://api.themoviedb.org/3/movie/upcoming?page=1&sort_by=popularity.desc&api_key=061b5b5397826fffc37bcaad1cc6814f'
  );

  const upcomingJson: { results: MovieDisplay[] } = await upcomingResponse.json();
  const popularJson: { results: MovieDisplay[] } = await popularResponse.json();

  return { popular: popularJson.results, upcoming: upcomingJson.results };
};
