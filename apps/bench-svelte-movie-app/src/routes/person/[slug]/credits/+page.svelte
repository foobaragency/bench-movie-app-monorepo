<script lang="ts">
	import CardGrid from '@/components/CardGrid';
	import MovieCard from '@/components/MovieCard';
	import type { PageData } from './$types';

	export let data: PageData;
</script>

<div class="px-10">
	<h2 class="text:xl mb-3 font-bold lg:text-3xl mt-10">
		All Credits for
		{data.details.name}
	</h2>
	<CardGrid>
		{#each data.credits as movie}
			<MovieCard {movie} />
		{/each}
	</CardGrid>
</div>
