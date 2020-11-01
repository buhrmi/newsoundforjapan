<script>
import { inertia } from 'inertia-svelte'
import formatTime from 'format_time'
export let place
export let gigs
export let start_at
export let current_user_gig
</script>

<h1>{place.name}</h1>

<h2>Lineup on {formatTime(start_at, 'date')}.</h2>

<div class="lineup">
  {#each gigs as gig}
    <div class="talent">
      <a use:inertia href="/users/{gig.talent.id}">
        {gig.talent.display_name}
      </a>
    </div>
  {:else}
    Nothing seems to be happening.
  {/each}
  {#if !current_user_gig}
    Do you want to play on this day? You can <a use:inertia={{method: 'POST', data: {gig: {place_id: place.id, start_at: start_at}}}} href="/gigs">add yourself to the lineup</a>.
  {/if}
</div>
