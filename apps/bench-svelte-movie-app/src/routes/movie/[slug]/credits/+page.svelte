<script lang="ts">
	import type { CrewMember } from '@/types/castAndCrew';
	import PersonCard from '@/components/PersonCard';
	import CardGrid from '@/components/CardGrid';
	import type { PageData } from './$types';

	export let data: PageData;

	const { cast, crew } = data.credits;
	const crewByJob: { [job: string]: CrewMember[] } = {};
	crew.forEach((crewMember) => {
		if (!crewByJob[crewMember.job]) {
			crewByJob[crewMember.job] = [crewMember];
		} else {
			crewByJob[crewMember.job].push(crewMember);
		}
	});

	const IMAGE_BASE_URL = 'https://image.tmdb.org/t/p';
</script>

<div class="flex items-center gap-10 px-10 py-5 bg-slate-500">
	<!-- TODO: fix this image style -->
	<img
		class="w-24"
		src="{IMAGE_BASE_URL}/original{data.movie.poster_path}"
		alt={data.movie.title}
	/>
	<div class="flex flex-col">
		<h1 class="text-white text-3xl">
			{data.movie.title}
			<span class="opacity-80">({new Date(data.movie.release_date).getFullYear()})</span>
		</h1>
		<a href="/movie/{data.movie.id}" class="text-white hover:underline">&larr; Go back</a>
	</div>
</div>

<div class="px-10">
	<h2 class="text:xl mb-3 font-bold lg:text-3xl mt-10">Cast 🍿</h2>
	<CardGrid>
		{#each cast as actor}
			<PersonCard person={actor} />
		{/each}
	</CardGrid>
	<h2 class="text:xl my-3 font-bold lg:text-3xl">Crew 🎥</h2>
	{#each Object.keys(crewByJob) as job}
		<h3 class="text-xl">{job}</h3>
		<CardGrid>
			{#each crewByJob[job] as jobMember}
				<PersonCard person={jobMember} />
			{/each}
		</CardGrid>
	{/each}
</div>
