<script>
	import { page } from '$app/stores';
	import CardGrid from '@/components/CardGrid';
	import MovieCard from '@/components/MovieCard';
	const query = $page.url.searchParams.get('query');
	import Search from '../Search.svelte';

	/** @type {import('./$types').PageData} */
	export let data;
</script>

<div class="flex flex-col gap-5 p-10">
	<form method="get" action="/search">
		<Search placeholder={query || ''} />
	</form>
	{#if data.results.length > 0}
		<h3>Search results for '{query}':</h3>
		<CardGrid>
			{#each data.results as movie}
				<MovieCard {movie} />
			{/each}
		</CardGrid>
	{:else}
		<span>no results for '{query}' 🙁</span>
	{/if}
</div>
