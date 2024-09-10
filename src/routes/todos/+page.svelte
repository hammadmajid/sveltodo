<script lang="ts">
	import { Button } from '$lib/components/ui/button';
	import { onMount } from 'svelte';

	let todos: string | undefined | null = $state();

	onMount(() => {
		todos = localStorage.getItem('todos.txt');
	});
</script>

<main class="mx-auto my-12 space-y-4 px-4 md:w-1/2">
	<h1 class="scroll-m-20 text-4xl font-extrabold tracking-tight lg:text-5xl">Todos</h1>
	<div class="bg-muted px-4 py-8">
		{#if todos}
			{todos}
		{:else}
			<p>No todos left.</p>
		{/if}
	</div>
</main>

<footer>
	<Button href="/settings" variant="link">Settings</Button>
</footer>
