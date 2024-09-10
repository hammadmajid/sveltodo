<script lang="ts">
	import * as Alert from '$lib/components/ui/alert';
	import { Button } from '$lib/components/ui/button';
	import { CircleAlert, Settings } from 'lucide-svelte';
	import { onMount } from 'svelte';

	let todos: string | undefined | null = $state();

	onMount(() => {
		todos = localStorage.getItem('todos.txt');
	});
</script>

<main class="mx-auto my-12 space-y-4 px-4 md:w-1/2">
	<h1 class="flex items-center justify-between">
		<span class="scroll-m-20 text-4xl font-extrabold tracking-tight lg:text-5xl"> Todos </span>
		<span>
			<Button variant="outline" href="/settings">
				<Settings />
			</Button>
		</span>
	</h1>
	<Alert.Root variant="destructive">
		<CircleAlert class="h-4 w-4" />
		<Alert.Title>Caution</Alert.Title>
		<Alert.Description
			>This is pre-alpha software, actively in development, and documentation is sparse. Use at your
			own risk.</Alert.Description
		>
	</Alert.Root>
	<div class="bg-muted px-4 py-8">
		{#if todos}
			{todos}
		{:else}
			<p>No todos left.</p>
		{/if}
	</div>
</main>
