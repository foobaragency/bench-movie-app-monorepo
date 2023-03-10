import type { PageLoad } from './$types';

export const load: PageLoad = async ({ parent }) => {
	const personDetails = await parent();

	return personDetails;
};
