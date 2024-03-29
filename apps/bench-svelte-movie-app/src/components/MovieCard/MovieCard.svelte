<script lang="ts">
	import type { Movie, MovieDisplay } from '@/types/movie';
	import HeartIcon from './HeartIcon.svelte';
	import { userSessionId, userAccount, userWatchlist } from '@/userStore';

	export let movie: MovieDisplay;

	const IMAGE_BASE_URL = 'https://image.tmdb.org/t/p';

	$: isOnWatchlist = $userWatchlist?.some((other: Movie) => other.id === movie.id);

	const handleWatchlistClick = async () => {
		if (!$userSessionId || !$userAccount) {
			const authResponse = await fetch(
				'https://api.themoviedb.org/3/authentication/token/new?api_key=061b5b5397826fffc37bcaad1cc6814f'
			);
			const authData = await authResponse.json();
			window.location.href = `https://www.themoviedb.org/authenticate/${authData.request_token}?redirect_to=${window.location}`;
			return;
		}

		const addToWatchlistResponse = await fetch(
			`https://api.themoviedb.org/3/account/${$userAccount.id}/watchlist?api_key=061b5b5397826fffc37bcaad1cc6814f&session_id=${$userSessionId}`,
			{
				method: 'POST',
				headers: {
					'Content-Type': 'application/json'
				},
				body: JSON.stringify({
					media_type: 'movie',
					media_id: movie.id,
					watchlist: !isOnWatchlist
				})
			}
		);

		if (!addToWatchlistResponse.ok) {
			return;
		}

		if (isOnWatchlist) {
			$userWatchlist = $userWatchlist?.filter((watchlistMovie) => watchlistMovie.id !== movie.id);
		} else {
			$userWatchlist?.push(movie as Movie);
			$userWatchlist = $userWatchlist;
		}
	};
</script>

<div class="relative">
	<a href="/movie/{movie.id}" target="_self">
		<figure class="w-44">
			{#if movie.poster_path}
				<img
					class="mx-auto md:h-auto rounded-xl shadow-md"
					src="{IMAGE_BASE_URL}/original/{movie.poster_path}"
					alt={movie.title}
				/>
			{:else}
				<svg
					xmlns="http://www.w3.org/2000/svg"
					fill="gray"
					viewBox="0 0 24 36"
					stroke-width="1.5"
					stroke="gray"
					class="w-full flex items-center shadow-md rounded-xl bg-gray-100"
				>
					<path
						stroke-linecap="round"
						stroke-linejoin="round"
						d="M3.375 19.5h17.25m-17.25 0a1.125 1.125 0 01-1.125-1.125M3.375 19.5h1.5C5.496 19.5 6 18.996 6 18.375m-3.75 0V5.625m0 12.75v-1.5c0-.621.504-1.125 1.125-1.125m18.375 2.625V5.625m0 12.75c0 .621-.504 1.125-1.125 1.125m1.125-1.125v-1.5c0-.621-.504-1.125-1.125-1.125m0 3.75h-1.5A1.125 1.125 0 0118 18.375M20.625 4.5H3.375m17.25 0c.621 0 1.125.504 1.125 1.125M20.625 4.5h-1.5C18.504 4.5 18 5.004 18 5.625m3.75 0v1.5c0 .621-.504 1.125-1.125 1.125M3.375 4.5c-.621 0-1.125.504-1.125 1.125M3.375 4.5h1.5C5.496 4.5 6 5.004 6 5.625m-3.75 0v1.5c0 .621.504 1.125 1.125 1.125m0 0h1.5m-1.5 0c-.621 0-1.125.504-1.125 1.125v1.5c0 .621.504 1.125 1.125 1.125m1.5-3.75C5.496 8.25 6 7.746 6 7.125v-1.5M4.875 8.25C5.496 8.25 6 8.754 6 9.375v1.5m0-5.25v5.25m0-5.25C6 5.004 6.504 4.5 7.125 4.5h9.75c.621 0 1.125.504 1.125 1.125m1.125 2.625h1.5m-1.5 0A1.125 1.125 0 0118 7.125v-1.5m1.125 2.625c-.621 0-1.125.504-1.125 1.125v1.5m2.625-2.625c.621 0 1.125.504 1.125 1.125v1.5c0 .621-.504 1.125-1.125 1.125M18 5.625v5.25M7.125 12h9.75m-9.75 0A1.125 1.125 0 016 10.875M7.125 12C6.504 12 6 12.504 6 13.125m0-2.25C6 11.496 5.496 12 4.875 12M18 10.875c0 .621-.504 1.125-1.125 1.125M18 10.875c0 .621.504 1.125 1.125 1.125m-2.25 0c.621 0 1.125.504 1.125 1.125m-12 5.25v-5.25m0 5.25c0 .621.504 1.125 1.125 1.125h9.75c.621 0 1.125-.504 1.125-1.125m-12 0v-1.5c0-.621-.504-1.125-1.125-1.125M18 18.375v-5.25m0 5.25v-1.5c0-.621.504-1.125 1.125-1.125M18 13.125v1.5c0 .621.504 1.125 1.125 1.125M18 13.125c0-.621.504-1.125 1.125-1.125M6 13.125v1.5c0 .621-.504 1.125-1.125 1.125M6 13.125C6 12.504 5.496 12 4.875 12m-1.5 0h1.5m-1.5 0c-.621 0-1.125.504-1.125 1.125v1.5c0 .621.504 1.125 1.125 1.125M19.125 12h1.5m0 0c.621 0 1.125.504 1.125 1.125v1.5c0 .621-.504 1.125-1.125 1.125m-17.25 0h1.5m14.25 0h1.5"
						transform="translate(0 4)"
					/>
				</svg>
			{/if}
			<figcaption class="p-1.5 text-slate-900 dark:text-slate-700">
				<div class="text-sm font-bold">{movie.title}</div>
				<div class="text-xs font-thin">
					{new Date(movie.release_date).toDateString()}
				</div>
			</figcaption>
		</figure>
	</a>
	<button
		on:click|stopPropagation={handleWatchlistClick}
		class="absolute top-1 right-1 text-gray-300 hover:text-white"
	>
		<HeartIcon filled={isOnWatchlist || false} />
	</button>
</div>
