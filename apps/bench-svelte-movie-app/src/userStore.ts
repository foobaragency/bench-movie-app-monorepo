import { writable } from 'svelte/store';
import type { Movie } from '@/types/movie';
import type { User } from '@/types/user';

export const userSessionId = writable<string | undefined>();
export const userWatchlist = writable<Movie[] | undefined>();
export const userAccount = writable<User | undefined>();
