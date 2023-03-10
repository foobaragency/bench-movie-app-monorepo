<script lang="ts">
	import Header from '@/components/Header';
	import { userSessionId } from '@/userStore';
	import '../app.css';
	import type { PageData } from './$types';

	/** @type {import('./$types').PageData} */
	export let data: PageData;
	$userSessionId = data.sessionId;
</script>

<div class="app">
	<Header />
	<main>
		<slot />
	</main>
</div>
