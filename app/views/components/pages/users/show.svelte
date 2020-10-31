<script>
  import Gig from 'components/gig.svelte'
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
  <h3>Upcoming Shows</h3>

  {#if gigs}
    {#each gigs as gig}
      <Gig {gig} />
    {/each}
  {:else}
    No upcoming gigs.
  {/if}
{/if}

<style>

</style>