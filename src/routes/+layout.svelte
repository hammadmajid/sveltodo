<script lang="ts">
	import '../app.css';
	import { ModeWatcher } from 'mode-watcher';

	interface Props {
		children: import('svelte').Snippet;
	}

	const { children }: Props = $props();
</script>

<ModeWatcher />
<div class="min-h-screen">
	{@render children()}
</div>
