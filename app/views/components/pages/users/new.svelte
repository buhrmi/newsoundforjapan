<script>
  import { page, inertia } from 'inertia-svelte'
</script>

{#if !$page.current_user} 
  <br><br><a href="/auth/twitch">Log in with Twitch</a> 
{/if}


