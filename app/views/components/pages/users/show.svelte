<script>
import { Inertia } from '@inertiajs/inertia'
import { page } from 'inertia-svelte'
import { stringify } from 'querystring'

export let user
export let gigs
let icsURL
function saveICS() {
  Inertia.reload({method: 'PUT', data: {user: {ics_url: icsURL}}})
}
</script>


{#if $page.current_user && $page.current_user.id == user.id && !$page.current_user.ics_url}
  Please enter the URL to your Google Calendar .ics file to add your gigs
  {#each $page.current_user.calendars as calendar}
    <input type="text" bind:value={icsURL}><button on:click={saveICS}>Submit</button><br>
  {/each}
{:else}
  <h2>{user.name}</h2>
  <h3>Upcoming Gigs</h3>

  {#if gigs}
    {#each gigs as gig}
      <div class="gig">
        {gig.summary}<br>
        {gig.start_at}
      </div>
    {/each}
  {:else}
    No upcoming gigs.
  {/if}
{/if}

<style>
.gig {
  border: 1px solid #444;
  padding: 15px;
  margin-bottom: 12px;
}

</style>