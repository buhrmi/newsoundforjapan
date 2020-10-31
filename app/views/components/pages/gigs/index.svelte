<script>
import Gig from 'components/gig.svelte'
export let upcoming
export let past
</script>

<h1>Upcoming Shows</h1>

{#each upcoming as gig}
  <Gig {gig} />
{:else}
  No upcoming shows. Please check back later
{/each}

<h2>Past Shows</h2>

{#each past as gig}
  <Gig {gig} />
{:else}
  No past shows
{/each}
