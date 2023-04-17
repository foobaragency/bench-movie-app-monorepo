<script lang="ts">
	import CardGrid from '@/components/CardGrid';
	import MovieCard from '@/components/MovieCard';
	import { userWatchlist } from '@/userStore';
</script>

<div class="px-10">
	<h2 class="text:xl mb-3 font-bold lg:text-3xl mt-10">My Watchlist 🎬</h2>
	{#if $userWatchlist}
		<CardGrid>
			{#each $userWatchlist as movie}
				<MovieCard {movie} />
			{/each}
		</CardGrid>
	{:else}
		<p>Your watchlist is empty</p>
	{/if}
</div>
