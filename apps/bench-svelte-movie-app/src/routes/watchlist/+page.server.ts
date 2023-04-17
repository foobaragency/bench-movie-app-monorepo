import { redirect } from '@sveltejs/kit';
import type { PageServerLoad } from './$types';

export const load: PageServerLoad = async ({ cookies, url }) => {
  if (!cookies.get('sessionId')) {
    const authResponse = await fetch(
      'https://api.themoviedb.org/3/authentication/token/new?api_key=061b5b5397826fffc37bcaad1cc6814f'
    );
    const authData = await authResponse.json();
    throw redirect(
      302,
      `https://www.themoviedb.org/authenticate/${authData.request_token
      }?redirect_to=${url.toString()}`
    );
  }
};
