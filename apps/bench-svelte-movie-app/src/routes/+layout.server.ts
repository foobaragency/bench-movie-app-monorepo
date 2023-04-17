import type { Movie } from '@/types/movie';
import type { User } from '@/types/user';
import type { LayoutServerLoad } from './$types';
type SessionResponse = { session_id: string };

export const load: LayoutServerLoad = async ({
  fetch,
  url,
  cookies
}): Promise<{
  sessionId: string | undefined;
  userAccount: User | undefined;
  watchlist: Movie[] | undefined;
}> => {
  const request_token = url.searchParams.get('request_token');
  let sessionId = cookies.get('sessionId');
  if (request_token && sessionId === undefined) {
    const sessionResponse = await fetch(
      'https://api.themoviedb.org/3/authentication/session/new?api_key=061b5b5397826fffc37bcaad1cc6814f',
      {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({ request_token })
      }
    );
    if (sessionResponse.ok) {
      const sessionJson = (await sessionResponse.json()) as SessionResponse;
      sessionId = sessionJson.session_id;
      cookies.set('sessionId', sessionId);
    }
  }

  let watchlist = [];
  let userAccount;
  if (sessionId) {
    const accountDetailsResponse = await fetch(
      `https://api.themoviedb.org/3/account?api_key=061b5b5397826fffc37bcaad1cc6814f&session_id=${sessionId}`
    );
    userAccount = await accountDetailsResponse.json();

    const watchlistResponse = await fetch(
      `https://api.themoviedb.org/3/account/${userAccount.id}/watchlist/movies?api_key=061b5b5397826fffc37bcaad1cc6814f&session_id=${sessionId}`
    );

    const watchlistJson = await watchlistResponse.json();
    watchlist = watchlistJson.results;
  }

  return { sessionId, userAccount, watchlist };
};
