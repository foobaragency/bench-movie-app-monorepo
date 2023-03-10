<script lang="ts">
	import SearchBgImage from '$lib/images/search-bg-blur.webp';
	import Category from './Category.svelte';
	import Search from './Search.svelte';
	import type { PageData } from './$types';

	/** @type {import('./$types').PageData} */
	export let data: PageData;
</script>

<svelte:head>
	<title>Svelte Movie App</title>
	<meta name="description" content="Svelte movie app" />
</svelte:head>

<div
	class="mb-3 flex h-80 flex-col justify-center  bg-cover px-10"
	style="background-image: url({SearchBgImage})"
>
	<div class="text-3xl font-bold text-slate-50">
		Millions of movie for you to discover and explore!
	</div>

	<form method="get" class="mt-4" action="/search">
		<Search />
	</form>
</div>

<div class="px-1.5">
	<h2 class="text:xl mb-3 font-bold lg:text-3xl">Most popular 🔥</h2>
	<Category movies={data.popular} />
	<h2 class="text:xl mb-3 font-bold lg:text-3xl">Upcoming 👀</h2>
	<Category movies={data.upcoming} />
</div>
