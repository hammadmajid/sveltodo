<script lang="ts">
	import { ChevronLeft, Github, Moon, Save, SquarePen, Sun, Trash } from 'lucide-svelte';

	import { goto } from '$app/navigation';
	import * as AlertDialog from '$lib/components/ui/alert-dialog';
	import { Button } from '$lib/components/ui/button/index.js';
	import * as DropdownMenu from '$lib/components/ui/dropdown-menu/index.js';
	import type { ButtonEventHandler, CustomEventHandler } from 'bits-ui';
	import { resetMode, setMode } from 'mode-watcher';
	import { onMount } from 'svelte';
	import { Textarea } from '$lib/components/ui/textarea';
	import * as Dialog from '$lib/components/ui/dialog';

	let todos: string;

	let deleteTodoTxt: (e: CustomEventHandler<MouseEvent, HTMLButtonElement>) => void;
	let saveTodoTxt: { (): void; (e: ButtonEventHandler<MouseEvent>): void };

	onMount(() => {
		deleteTodoTxt = () => {
			localStorage.removeItem('todos.txt');
			goto('/');
		};

		saveTodoTxt = () => {
			localStorage.setItem('todos.txt', todos);
		};

		const getTodos = () => {
			return localStorage.getItem('todos.txt') as string;
		};

		todos = getTodos();
	});

	function exportTodoTxt() {
		const blob = new Blob([JSON.stringify(todos)], { type: 'text/plain' });
		const url = URL.createObjectURL(blob);
		const a = document.createElement('a');
		a.href = url;
		a.download = 'todo.txt';
		a.click();
		URL.revokeObjectURL(url);
	}
</script>

<main class="lg:1/2 mx-auto my-12 space-y-12 px-4 md:w-3/4">
	<div class="space-y-4">
		<Button class="p-0" href="/todos" variant="link"><ChevronLeft /> Go back</Button>
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
			<p>Manual edit</p>

			<Dialog.Root>
				<Dialog.Trigger>
					<Button variant="outline" class="flex items-center gap-2"
						><SquarePen class="w-4" /> Edit</Button
					>
				</Dialog.Trigger>
				<Dialog.Content>
					<Dialog.Header>
						<Dialog.Title>
							<span class="flex items-center gap-2">
								<SquarePen />
								Edit
							</span>
						</Dialog.Title>
						<Dialog.Description>Manually edit your todo.txt file.</Dialog.Description>
					</Dialog.Header>
					<div class="grid w-full gap-2">
						<Textarea bind:value={todos} placeholder="Nothing to see here." />
					</div>
					<Dialog.Footer>
						<Button type="submit" on:click={saveTodoTxt}>Save changes</Button>
					</Dialog.Footer>
				</Dialog.Content>
			</Dialog.Root>
		</div>
		<div class="flex items-center justify-between">
			<p>Export todo.txt</p>
			<Button variant="outline" on:click={exportTodoTxt} class="flex items-center gap-2">
				<Save class="w-4"/>
				Export
			</Button>
		</div>
		<div class="flex items-center justify-between">
			<p>Delete todo.txt</p>
			<AlertDialog.Root>
				<AlertDialog.Trigger>
					<Button variant="destructive" class="flex items-center gap-2">
						<Trash class="w-4" />
						Delete
					</Button>
				</AlertDialog.Trigger>
				<AlertDialog.Content>
					<AlertDialog.Header>
						<AlertDialog.Title>Are you absolutely sure?</AlertDialog.Title>
						<AlertDialog.Description>
							This action cannot be undone. This will permanently delete your todo.txt file stored
							in localStorage.
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
	<p class="text-center">
		<Button class="flex gap-2" href="https://github.com/hammadmajid/sveltodo" variant="link">
			<Github />
			hammadmajid/sveltodo
		</Button>
	</p>
</main>
