<script lang="ts">
	import SuperDebug, { superForm, defaults } from 'sveltekit-superforms';
	import { zod, zodClient } from 'sveltekit-superforms/adapters';
	import { z } from 'zod';

	import * as Form from '$lib/components/ui/form/index.js';
	import { Input } from '$lib/components/ui/input/index.js';

	import { browser } from '$app/environment';
	import { onMount } from 'svelte';
	import { goto } from '$app/navigation';

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

			goto('/settings');
		}
	});

	const { form: formData, enhance, message, delayed } = form;
</script>

<svelte:head>
	<title>Import</title>
</svelte:head>

<form method="POST" enctype="multipart/form-data" class="space-y-4" use:enhance>
	{#if $message}
		<p>{message}</p>
	{/if}

	<div>
		<Form.Field {form} name="file">
			<Form.Control let:attrs>
				<Form.Label>Select file</Form.Label>
				<Input
					{...attrs}
					type="file"
					accept="text/plain"
					on:input={(e) => ($formData.file = e.currentTarget.files?.item(0) as File)}
				/>
			</Form.Control>
			<Form.FieldErrors />
		</Form.Field>

		<Form.Button disabled={$delayed}>Submit</Form.Button>
	</div>

	{#if browser}
		<SuperDebug data={$formData} />
	{/if}
</form>
