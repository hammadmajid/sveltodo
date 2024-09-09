<script>
	import { enhance } from '$app/forms';
	import { Upload, CirclePlus } from 'lucide-svelte';
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

<form method="POST" use:enhance class="flex items-center justify-center gap-2">
	<a href="/setup/import" class="block">
		<div class="flex items-center justify-center gap-2 rounded-md border bg-muted p-12">
			<Upload />
			Import
		</div>
	</a>
	<button type="submit">
		<div class="flex items-center justify-center gap-2 rounded-md border bg-muted p-12">
			<CirclePlus />
			Create
		</div>
	</button>
</form>
