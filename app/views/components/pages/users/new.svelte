<script>
  import { page, inertia } from 'inertia-svelte'
</script>

{#if !$page.current_user} 
  <p>New Sound For Japan automatically promotes gigs from your Google Calendar</p>
  <a href="/auth/google_oauth2">Connect a Google Calendar</a> 
{/if}


