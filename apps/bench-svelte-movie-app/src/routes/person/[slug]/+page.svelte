<script lang="ts">
	import MovieCard from '@/components/MovieCard';
	import Slider from '@/components/Slider';
	import type { PageData } from './$types';

	export let data: PageData;

	const { details, credits } = data;

	const personalInfo: { label: string; value: string }[] = [
		...((details.birthday && [
			{
				label: 'Born',
				value: details.birthday
			}
		]) ||
			[]),
		...((details.place_of_birth && [
			{
				label: 'Place of Birth',
				value: details.place_of_birth
			}
		]) ||
			[]),
		...((details.deathday && [{ label: 'Died', value: details.deathday }]) || []),
		...((details.also_known_as && [
			{
				label: 'Also known as',
				value: details.also_known_as.join('\r\n')
			}
		]) ||
			[]),
		{
			label: 'Known for',
			value: details.known_for_department
		},
		{
			label: 'Known Credits',
			value: credits.length.toString()
		}
	];

	const IMAGE_BASE_URL = 'https://image.tmdb.org/t/p';
</script>

<div class="flex p-12 md:gap-12">
	<div class="flex flex-col flex-shrink-0">
		<img
			src="{IMAGE_BASE_URL}/original/{details.profile_path}"
			alt={details.name}
			class="rounded-md
      shadow-xl w-56"
		/>
		<h2 class="text-2xl my-4">Personal Info</h2>
		{#each personalInfo as item}
			<div class="max-w-xs mb-4">
				<p class="font-bold">{item.label}</p>
				<span class="whitespace-pre-line">{item.value}</span>
			</div>
		{/each}
	</div>

	<div class="flex flex-col min-w-0">
		<h1 class="text-6xl">{details.name}</h1>

		<h2 class="text-2xl mt-4">Biography</h2>
		<p class="mt-2">{details.biography}</p>

		<h2 class="text-2xl my-4">Known for</h2>
		<Slider>
			{#each credits.slice(0, 10) as movie}
				<MovieCard {movie} />
			{/each}
			{#if credits.length > 10}
				<a
					href="/person/{details.id}/credits"
					class="text-black self-center w-20 shrink-0 mx-3
          hover:underline"
					>See all &rarr;
				</a>
			{/if}
		</Slider>
	</div>
</div>
