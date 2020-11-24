<script>
import { inertia, page } from 'inertia-svelte'
import formatTime from 'format_time'
export let event
export let gigs
export let current_user_gig
</script>

<h1>{event.name}</h1>
{formatTime(event.start_at)}


<h2>LINEUP</h2>

{#each gigs as gig}
  <a use:inertia href="/talents/{gig.talent.id}">{gig.talent.display_name}</a>
{/each}

{#if !current_user_gig}
<div class="join">
  <h2>CALL FOR DJs</h2>
  {#if $page.current_user}
    Do you want to play at this event?<br>
    <a use:inertia={{method: 'POST', data: {gig: {event_id: event.id}}}} href="/gigs" class="btn-big">
      <span class="sc-text">
        Reserve DJ slot
      </span> 
    </a>
  {:else}
    Do you want to play at this event? Log in with Twitter to reserve a DJ slot.<br>
    <a href="/auth/twitter?return_to={encodeURIComponent(window.location)}" class="btn-big">
      <span class="sc-text">
        Log in with Twitter
      </span> 
    </a>
  {/if}
</div>
{/if}

<style>
.join {margin-top: 50px;
  /* text-align: center; */
}
.join .btn-big {
  margin-top: 12px;
}
</style>