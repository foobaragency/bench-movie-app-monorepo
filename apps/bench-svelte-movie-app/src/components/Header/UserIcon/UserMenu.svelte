<script lang="ts">
	import { userSessionId } from '../../../userStore';

	const handleLoginClick = async () => {
		// console.log('LOGIN');
		const authResponse = await fetch(
			'https://api.themoviedb.org/3/authentication/token/new?api_key=061b5b5397826fffc37bcaad1cc6814f'
		);
		const authData = await authResponse.json();
		window.location.href = `https://www.themoviedb.org/authenticate/${authData.request_token}?redirect_to=${window.location}`;
	};
</script>

<div class="absolute bg-white rounded-lg shadow-md mt-2">
	{#if $userSessionId}
		<div>congrats you're logged in</div>
	{:else}
		<button type="button" class="p-3 rounded-lg hover:bg-gray-200" on:click={handleLoginClick}>
			Login
		</button>
	{/if}
</div>
