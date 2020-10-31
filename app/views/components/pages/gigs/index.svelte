<script>
import Gig from 'components/gig.svelte'
export let upcoming

</script>

<h1>Upcoming Shows</h1>

{#each upcoming as gig}
  <Gig {gig} />
{/each}

