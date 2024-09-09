<script lang="ts">
	import '../app.css';
	import { ModeWatcher } from 'mode-watcher';

	interface Props {
		children: import('svelte').Snippet;
	}
</script>

<ModeWatcher />
<div class="min-h-screen">
	<slot></slot>
</div>
