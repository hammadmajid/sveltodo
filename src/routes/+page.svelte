<script lang="ts">
	import * as Alert from '$lib/components/ui/alert/index.js';
	import { Button } from '$lib/components/ui/button/index';

	import { CircleAlert, Github } from 'lucide-svelte';
</script>

<svelte:head>
	<title>sveltodo</title>
</svelte:head>

<main class="gird px-4 mx-auto min-h-screen place-content-center space-y-8 md:w-1/2">
	<div>
		<h1 class="scroll-m-20 text-4xl font-extrabold tracking-tight lg:text-5xl">sveltodo</h1>
		<p class="leading-7 text-muted-foreground [&:not(:first-child)]:mt-6">
			Hi, this is a modern web app to interface with
			<a
				href="https://github.com/todotxt/todo.txt"
				class="font-medium text-primary underline underline-offset-4"
			>
				todo.txt
			</a>
			file. The file will the stored in
			<a
				href="https://developer.mozilla.org/en-US/docs/Web/API/Window/localStorage"
				class="font-medium text-primary underline underline-offset-4">localStorage</a
			>.
		</p>
	</div>

	<Alert.Root variant="destructive">
		<CircleAlert class="h-4 w-4" />
		<Alert.Title>Caution</Alert.Title>
		<Alert.Description
			>This is pre-alpha software, actively in development, and documentation is sparse. Use at your
			own risk.</Alert.Description
		>
	</Alert.Root>

	<div class="flex items-center justify-center gap-2">
		<Button href="/setup" class="w-full">Get started</Button>
		<Button href="https://github.com/hammadmajid/sveltodo" variant="secondary"><Github /></Button>
	</div>
</main>
