<script lang="ts">
	import { superForm, defaults } from 'sveltekit-superforms';
	import { zod, zodClient } from 'sveltekit-superforms/adapters';
	import { z } from 'zod';

	import * as Form from '$lib/components/ui/form/index.js';
	import { Input } from '$lib/components/ui/input/index.js';

	import { onMount } from 'svelte';
	import { goto } from '$app/navigation';
	import { Button } from '$lib/components/ui/button';
	import { ChevronLeft } from 'lucide-svelte';

	let todos: (content: string) => void;
	onMount(() => {
		todos = (content: string) => {
			localStorage.setItem('todos.txt', content);
		};
	});

	export const setupForm = z.object({
		file: z
			.instanceof(File, { message: 'Please upload a file.' })
			.refine((f) => f.size < 5_000_000, 'Max 5 MB upload size.')
	});

	const form = superForm(defaults(zod(setupForm)), {
		SPA: true,
		validators: zodClient(setupForm),
		onUpdate({ form }) {
			const reader = new FileReader();
			reader.onload = (e) => {
				todos(e.target?.result as string);
			};

			reader.readAsText(form.data.file);

			goto('/todos');
		}
	});

	const { form: formData, enhance, message, delayed } = form;
</script>

<svelte:head>
	<title>Import</title>
</svelte:head>

<form method="POST" enctype="multipart/form-data" class="space-y-8" use:enhance>
	{#if $message}
		<p>{message}</p>
	{/if}

	<div class="space-y-4">
		<Button class="p-0" href="/setup" variant="link"><ChevronLeft /> Go back</Button>
		<h1 class="scroll-m-20 text-4xl font-extrabold tracking-tight lg:text-5xl">Select file</h1>
	</div>

	<div class="space-y-2">
		<Form.Field {form} name="file">
			<Form.Control let:attrs>
				<Form.Label class="sr-only">Select file</Form.Label>
				<Input
					{...attrs}
					type="file"
					accept="text/plain"
					on:input={(e) => ($formData.file = e.currentTarget.files?.item(0) as File)}
				/>
			</Form.Control>
			<Form.FieldErrors />
		</Form.Field>

		<Form.Button disabled={$delayed} class="w-full">Submit</Form.Button>
	</div>
</form>
