<script>
import Gig from 'components/gig.svelte'
export let upcoming
export let past
</script>

<h1>Coming up</h1>

<div class="gigs flex">
  {#each upcoming as gig}
    <Gig {gig} />
  {:else}
    Nothing planned. Please check back later
  {/each}
</div>

<h1>Past</h1>

{#each past as gig}
  <Gig {gig} />
{:else}
  Nothing in the past.
{/each}
