<script lang="ts">
	import Header from '@/components/Header';
	import { userSessionId, userAccount, userWatchlist } from '@/userStore';
	import '../app.css';
	import type { PageData } from './$types';

	/** @type {import('./$types').PageData} */
	export let data: PageData;
	$userSessionId = data.sessionId;
	$userWatchlist = data.watchlist;
	$userAccount = data.userAccount;
</script>

<div class="app">
	<Header />
	<main>
		<slot />
	</main>
</div>
