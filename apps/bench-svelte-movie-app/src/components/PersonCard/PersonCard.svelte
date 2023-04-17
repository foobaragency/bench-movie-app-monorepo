<script lang="ts">
	import type { CastMember, CrewMember } from '@/types/castAndCrew';

	export let person: CastMember | CrewMember;
	const IMAGE_BASE_URL = 'https://image.tmdb.org/t/p';

	function isActor(person: CastMember | CrewMember): person is CastMember {
		return !!(person as CastMember).character;
	}

	const role = isActor(person) ? person.character : person.job;
</script>

<a href="/person/{person.id}">
	<figure class="bg-white shadow-xl rounded-xl w-36 my-2 shrink-0 h-72">
		<div class="bg-gray-200 rounded-t-xl">
			{#if person.profile_path}
				<img
					class="mx-auto md:h-auto rounded-t-xl"
					src="{IMAGE_BASE_URL}/original/{person.profile_path}"
					alt={person.name}
				/>
			{:else}
				<svg
					xmlns="http://www.w3.org/2000/svg"
					viewBox="0 0 24 36"
					fill="gray"
					class="w-full flex items-center"
				>
					<path
						fill-rule="evenodd"
						d="M7.5 6a4.5 4.5 0 119 0 4.5 4.5 0 01-9 0zM3.751 20.105a8.25 8.25 0 0116.498 0 .75.75 0 01-.437.695A18.683 18.683 0 0112 22.5c-2.786 0-5.433-.608-7.812-1.7a.75.75 0 01-.437-.695z"
						clip-rule="evenodd"
						transform="scale(1.333) translate(-3 3)"
					/>
				</svg>
			{/if}
		</div>
		<figcaption class="p-1.5 text-slate-900 dark:text-slate-700">
			<div class="text-sm font-bold">{person.name}</div>
			{#if role}
				<div class="text-xs font-thin line-clamp-2">
					{role}
				</div>
			{/if}
		</figcaption>
	</figure>
</a>
