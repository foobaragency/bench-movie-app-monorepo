import type { LayoutServerLoad } from './$types';
type SessionResponse = { session_id: string };

export const load: LayoutServerLoad = async ({
	fetch,
	url,
	cookies
}): Promise<{ sessionId: string | undefined }> => {
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
			console.log(sessionJson);
			sessionId = sessionJson.session_id;
			cookies.set('sessionId', sessionId);
		}
	}

	return { sessionId };
};
