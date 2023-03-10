<script lang="ts">
	import { page } from '$app/stores';
	import { userSessionId } from '../../../userStore';
	import UserMenu from './UserMenu.svelte';

	let showUserMenu = false;

	const handleToggleUserMenu = () => {
		showUserMenu = !showUserMenu;
	};
</script>

<div class="relative">
	<button
		type="button"
		class="flex rounded-full text-sm text-gray-400 hover:text-white
    focus:text-white focus:outline-none focus:ring-2 focus:ring-white focus:ring-offset-2 focus:ring-offset-gray-800"
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
		<UserMenu />
	{/if}
</div>
