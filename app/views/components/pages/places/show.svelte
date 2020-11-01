<script>
import { inertia, page } from 'inertia-svelte'
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
    <div class="join">
      Do you want to play at this event?<br>
    
      {#if $page.current_user}
        <a use:inertia={{method: 'POST', data: {gig: {place_id: place.id, start_at: start_at}}}} href="/gigs" class="btn-big">
          <span class="sc-text">
            Reserve a DJ slot
          </span> 
        </a>
      {:else}
        <a href="/auth/twitter" class="sc-btn sc--round sc--twitter">
          <span class="sc-text">
            Reserve a DJ slot
          </span> 
        </a>
      {/if}
    </div>
  {/if}
</div>

<style>

  .join {margin-top: 50px;
    text-align: center;
  }
  .join .btn-big {
    margin-top: 12px;
  }
</style>