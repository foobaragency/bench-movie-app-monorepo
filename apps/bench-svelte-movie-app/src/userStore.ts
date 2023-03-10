import { writable } from 'svelte/store';

export const userSessionId = writable<string | undefined>();
