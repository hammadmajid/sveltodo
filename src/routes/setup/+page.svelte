<script lang="ts">
	import { goto } from '$app/navigation';
	import { Button } from '$lib/components/ui/button';
	import { CirclePlus, Upload } from 'lucide-svelte';
	import { onMount } from 'svelte';

	let createTodoTxt: () => void;

	onMount(() => {
		createTodoTxt = () => {
			localStorage.setItem('todos.txt', '');
			goto('/todos');
		};
	});
</script>

<svelte:head>
	<title>Setup</title>
</svelte:head>

<div class="text-center">
	<h1 class="scroll-m-20 text-4xl font-extrabold tracking-tight lg:text-5xl">Select option</h1>
	<p class="leading-7 text-muted-foreground [&:not(:first-child)]:mt-6">
		You can import your existing todo.txt file or create new one.
	</p>
</div>

<div class="flex flex-col items-center justify-center gap-3 px-4 md:flex-row">
	<a href="/setup/import" class="block">
		<Button variant="outline" class="flex gap-2 p-12">
			<Upload />
			Import
		</Button>
	</a>
	<!-- <button type="submit" onclick={createTodoTxt}> -->
	<Button variant="outline" class="flex gap-2 p-12" on:click={createTodoTxt}>
		<CirclePlus />
		Create
	</Button>
</div>
