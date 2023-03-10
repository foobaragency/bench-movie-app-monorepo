<script lang="ts">
	import Slider from '@/components/Slider';
	import MovieCard from '@/components/MovieCard';
	import type { MovieDisplay } from '@/types/movie';

	export let movies: MovieDisplay[];
</script>

<Slider>
	{#each movies as movie}
		<MovieCard {movie} />
	{/each}
</Slider>
