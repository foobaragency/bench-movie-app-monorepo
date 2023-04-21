import { json } from '@sveltejs/kit';
import type { RequestHandler } from './$types';

export const POST = (async ({ cookies }) => {
  cookies.delete('sessionId', { path: '/' });
  return json({ success: true });
}) satisfies RequestHandler;
