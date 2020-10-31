<script>
import Gig from 'components/gig.svelte'
import { Inertia } from '@inertiajs/inertia'
import { page } from 'inertia-svelte'
import { stringify } from 'querystring'

export let user
export let gigs

function saveICS() {
  Inertia.reload({method: 'PUT', data: {user: {ics_url: user.ics_url}}})
}
</script>


{#if $page.current_user && $page.current_user.id == user.id && !$page.current_user.ics_url}
  <h1>Please let our visitors know your DJ schedule.</h1>
  Paste the URL to an .ics calendar file (eg. from Google Calendar).
  We will import gigs from the .ics file and promote them on our website.<br>
  <input type="text" bind:value={user.ics_url}><button on:click={saveICS}>Submit</button><br>
{:else}
  <h2>{user.name}</h2>
  <h3>Upcoming Gigs</h3>

  {#each gigs as gig}
      <Gig {gig} />
    {:else}
      No upcoming gigs.
  {/each}
{/if}

<style>

</style>