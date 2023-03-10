<script lang="ts">
	import PersonCard from '@/components/PersonCard';
	import Slider from '@/components/Slider';
	import Category from '../../Category.svelte';
	import type { PageData } from './$types';

	/** @type {import('./$types').PageData} */
	export let data: PageData;
	const {
		title,
		id,
		tagline,
		poster_path,
		backdrop_path,
		release_date,
		runtime,
		overview,
		genres
	} = data.movie;
	const { cast, crew } = data.credits;
	const director = crew.find((member) => member.job === 'Director');
	const { similar } = data;
	const IMAGE_BASE_URL = 'https://image.tmdb.org/t/p';
</script>

<div class="bg-cover" style="background-image: url({IMAGE_BASE_URL}/original/{backdrop_path})">
	<div
		class="w-full h-full flex md:gap-12 md:flex-row flex-col p-12
    backdrop-blur-sm from-gray-900 to-transparent bg-gradient-to-b"
	>
		<img
			src="{IMAGE_BASE_URL}/original/{poster_path}"
			alt={title}
			class="rounded-md
      shadow-xl w-120 h-full w-56"
		/>
		<div class="flex flex-col min-w-0">
			<h1 class="text-white text-6xl">
				{title}
				<span class="opacity-80">({new Date(release_date).getFullYear()})</span>
			</h1>
			<span class="text-white before:marker"
				>{release_date} &#x2022;
				{genres.map((genre) => genre.name).join(', ')} &#x2022;
				{Math.floor(runtime / 60)}h {runtime % 60}m
			</span>
			<span class="text-white opacity-80 mt-4 italic">{tagline}</span>
			<h2 class="text-white font-medium mt-4 text-2xl">Overview</h2>
			<p class="text-white">{overview}</p>
			<h2 class="text-white font-medium mt-4 text-2xl">Directed by</h2>
			<span>
				<a href="/person/{director?.id}" class="text-white hover:underline">
					{director?.name || 'Unknown'}
				</a>
			</span>
			<h2 class="font-medium mt-4 text-2xl text-white">Cast</h2>
			<Slider>
				{#each cast.slice(0, 10) as actor}
					<PersonCard person={actor} />
				{/each}
				<a
					href="/movie/{id}/credits"
					class="text-white self-center w-20 shrink-0 mx-3
          hover:underline">See all &rarr;</a
				>
			</Slider>
		</div>
	</div>
</div>

<div class="p-12">
	<h2 class="text:xl mb-3 font-bold lg:text-3xl">More like this 🔥</h2>
	<Category movies={similar} />
</div>
