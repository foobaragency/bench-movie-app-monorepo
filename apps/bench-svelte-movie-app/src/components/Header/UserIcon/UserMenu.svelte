<script>
	import { goto } from '$app/navigation';
	import { userAccount, userSessionId } from '@/userStore';
	const handleLogout = async () => {
		await fetch('/api/logout', {
			method: 'POST'
		});
		$userAccount = undefined;
		$userSessionId = undefined;
		goto('/');
	};
</script>

<div class="absolute z-10 bg-white rounded-lg shadow-md mt-2 p-3">
	<button class="hover:underline" on:mousedown={handleLogout}>Logout</button>
	<a class="hover:underline" href="/watchlist" on:click|stopPropagation>Watchlist</a>
</div>
