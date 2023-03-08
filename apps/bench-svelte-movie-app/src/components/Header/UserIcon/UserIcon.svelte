<script lang="ts">
	import { page } from '$app/stores';
	import { userSessionId } from '../../../userStore';

	const request_token = $page.url.searchParams.get('request_token');
	if (request_token) {
		fetch(
			'https://api.themoviedb.org/3/authentication/session/new?api_key=061b5b5397826fffc37bcaad1cc6814f',
			{
				method: 'POST',
				headers: {
					'Content-Type': 'application/json'
				},
				body: JSON.stringify({ request_token })
			}
		)
			.then((response) => response.json())
			.then((json) => userSessionId.set(json.session_token));
	}
	$: console.log($userSessionId);

	let showUserMenu = false;

	const handleToggleUserMenu = () => {
		showUserMenu = !showUserMenu;
	};

	const handleLoginClick = async () => {
		const authResponse = await fetch(
			'https://api.themoviedb.org/3/authentication/token/new?api_key=061b5b5397826fffc37bcaad1cc6814f'
		);
		const authData = await authResponse.json();
		window.location.href = `https://www.themoviedb.org/authenticate/${authData.request_token}?redirect_to=${window.location}`;
	};
</script>

<div class="relative">
	<button
		type="button"
		class="flex rounded-full text-sm text-gray-400 hover:text-white focus:outline-none focus:ring-2 focus:ring-white focus:ring-offset-2 focus:ring-offset-gray-800"
		id="user-menu-button"
		aria-expanded="false"
		aria-haspopup="true"
		on:click={handleToggleUserMenu}
	>
		<span class="sr-only">Open user menu</span>
		<svg
			xmlns="http://www.w3.org/2000/svg"
			fill="none"
			viewBox="0 0 24 24"
			stroke-width="1.5"
			stroke="currentColor"
			class="w-8 h-8 rounded-full p-1"
		>
			<path
				stroke-linecap="round"
				stroke-linejoin="round"
				d="M15.75 6a3.75 3.75 0 11-7.5 0 3.75 3.75 0 017.5 0zM4.501 20.118a7.5 7.5 0 0114.998 0A17.933 17.933 0 0112 21.75c-2.676 0-5.216-.584-7.499-1.632z"
			/>
		</svg>
	</button>
	{#if showUserMenu}
		<div class="absolute bg-white rounded-lg shadow-md mt-2">
			<button type="button" class="p-3 rounded-lg hover:bg-gray-200" on:click={handleLoginClick}>
				Login
			</button>
		</div>
	{/if}
</div>
