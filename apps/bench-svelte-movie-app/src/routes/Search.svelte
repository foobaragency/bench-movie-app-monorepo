<script lang="ts">
	import type { MovieDisplay } from '@/types/movie';

	export let placeholder = 'Search movies...';
	type SearchSuggestion = MovieDisplay & { vote_count: number };

	let autocompleteResults: SearchSuggestion[] = [];

	const handleSearchInputChange = async (event: Event) => {
		const response = await fetch(
			`https://api.themoviedb.org/3/search/movie?query=${
				(event.target as HTMLInputElement).value
			}&api_key=061b5b5397826fffc37bcaad1cc6814f`
		);
		autocompleteResults = (await response.json()).results
			.slice(0, 7)
			.sort((a: SearchSuggestion, b: SearchSuggestion) => b.vote_count - a.vote_count);
	};
</script>

<div class="relative">
	<div class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3">
		<svg
			aria-hidden="true"
			class="h-5 w-5 text-gray-500 dark:text-gray-400"
			fill="none"
			stroke="currentColor"
			viewBox="0 0 24 24"
			xmlns="http://www.w3.org/2000/svg"
		>
			<path
				stroke-linecap="round"
				stroke-linejoin="round"
				stroke-width="2"
				d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"
			/>
		</svg>
	</div>
	<input
		type="search"
		autocomplete="off"
		name="query"
		class="block w-full rounded-lg border border-gray-300 bg-gray-50 p-4 pl-10 text-sm text-gray-900 focus:border-gray-500 focus:ring-gray-500 dark:border-gray-600 dark:bg-gray-700 dark:text-white dark:placeholder-gray-400 dark:focus:border-gray-500 dark:focus:ring-gray-500 md:text-base lg:text-lg"
		{placeholder}
		required
		on:input={handleSearchInputChange}
	/>
	{#if autocompleteResults.length > 0}
		<div class="w-full bg-gray-50 absolute flex flex-col rounded-lg shadow-md">
			{#each autocompleteResults as result}
				<a
					href="/movie/{result.id}"
					class="border-b border-gray-300
          last:border-none p-5 hover:bg-slate-200
          first:rounded-t-lg last:rounded-b-lg"
				>
					{result.title}
					<span class="opacity-80">({new Date(result.release_date).getFullYear()})</span>
				</a>
			{/each}
		</div>
	{/if}
	<button
		type="submit"
		class="absolute top-0 right-0 h-full rounded-r-lg border border-gray-300 bg-gray-100 px-4 py-2 text-sm font-medium text-gray-500 hover:bg-gray-300 focus:outline-none focus:ring-4 focus:ring-gray-300 dark:bg-gray-600 dark:text-slate-50 dark:hover:bg-gray-700 dark:focus:ring-gray-800"
	>
		Search
	</button>
</div>
