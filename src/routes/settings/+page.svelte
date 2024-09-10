<script lang="ts">
	import { ChevronLeft, Moon, Sun } from 'lucide-svelte';

	import { goto } from '$app/navigation';
	import * as AlertDialog from '$lib/components/ui/alert-dialog';
	import { Button } from '$lib/components/ui/button/index.js';
	import * as DropdownMenu from '$lib/components/ui/dropdown-menu/index.js';
	import type { CustomEventHandler } from 'bits-ui';
	import { resetMode, setMode } from 'mode-watcher';
	import { onMount } from 'svelte';

	let deleteTodoTxt: (e: CustomEventHandler<MouseEvent, HTMLButtonElement>) => void;

	onMount(() => {
		deleteTodoTxt = () => {
			localStorage.removeItem('todos.txt');
			goto('/');
		};
	});
</script>

<main class="mx-auto my-12 space-y-12 px-4 md:w-1/2">
	<div class="space-y-4">
		<Button class="p-0" href="/" variant="link"><ChevronLeft /> Go back</Button>
		<h1 class="scroll-m-20 text-4xl font-extrabold tracking-tight lg:text-5xl">Settings</h1>
	</div>
	<div class="space-y-4">
		<div class="flex items-center justify-between">
			<p>Change theme</p>
			<DropdownMenu.Root>
				<DropdownMenu.Trigger asChild let:builder>
					<Button builders={[builder]} variant="outline" size="icon">
						<Sun
							class="h-[1.2rem] w-[1.2rem] rotate-0 scale-100 transition-all dark:-rotate-90 dark:scale-0"
						/>
						<Moon
							class="absolute h-[1.2rem] w-[1.2rem] rotate-90 scale-0 transition-all dark:rotate-0 dark:scale-100"
						/>
						<span class="sr-only">Toggle theme</span>
					</Button>
				</DropdownMenu.Trigger>
				<DropdownMenu.Content align="end">
					<DropdownMenu.Item on:click={() => setMode('light')}>Light</DropdownMenu.Item>
					<DropdownMenu.Item on:click={() => setMode('dark')}>Dark</DropdownMenu.Item>
					<DropdownMenu.Item on:click={() => resetMode()}>System</DropdownMenu.Item>
				</DropdownMenu.Content>
			</DropdownMenu.Root>
		</div>
		<div class="flex items-center justify-between">
			<p>Delete todo.txt</p>
			<AlertDialog.Root>
				<AlertDialog.Trigger>
					<Button variant="destructive">Delete</Button>
				</AlertDialog.Trigger>
				<AlertDialog.Content>
					<AlertDialog.Header>
						<AlertDialog.Title>Are you absolutely sure?</AlertDialog.Title>
						<AlertDialog.Description>
							This action cannot be undone. This will permanently delete your account and remove
							your data from our servers.
						</AlertDialog.Description>
					</AlertDialog.Header>
					<AlertDialog.Footer>
						<AlertDialog.Cancel>Cancel</AlertDialog.Cancel>
						<AlertDialog.Action on:click={deleteTodoTxt}>Continue</AlertDialog.Action>
					</AlertDialog.Footer>
				</AlertDialog.Content>
			</AlertDialog.Root>
		</div>
	</div>
</main>
