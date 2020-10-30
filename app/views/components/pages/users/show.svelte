<script>
import { Inertia } from '@inertiajs/inertia'
import { page } from 'inertia-svelte'
import { stringify } from 'querystring'

export let user
export let gigs

function pickCalendar(calendar) {
  Inertia.reload({method: 'PUT', data: {user: {google_calendar_id: calendar.id}}})
}
</script>


{#if $page.current_user && $page.current_user.id == user.id && !$page.current_user.google_calendar_id}
  Please pick the Google Calendar you use to manage your gigs<br>
  {#each $page.current_user.calendars as calendar}
    <button on:click={() => pickCalendar(calendar)}>{calendar.summary}</button><br>
  {/each}
{:else}
  <h2>{user.name}</h2>
  <h3>Upcoming Gigs</h3>

  {#if gigs}
    {#each gigs as gig}
      <div class="gig">
        {gig.summary}<br>
        {gig.start.date || gig.start.date_time}
      </div>
    {/each}
  {:else}
    No upcoming gigs.
  {/if}
{/if}

<style>
.gig {
  border: 1px solid #ddd;
  padding: 15px;
  margin-bottom: 12px;
}

</style>