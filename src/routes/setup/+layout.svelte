<script lang="ts">
	interface Props {
		children: import('svelte').Snippet;
	}

	const { children }: Props = $props();
</script>

<main class="gird mx-auto min-h-screen place-content-center space-y-8 px-4 md:w-1/2">
	{@render children()}
</main>
