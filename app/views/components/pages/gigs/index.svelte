<script>
import Gig from 'components/gig.svelte'
export let upcoming
export let past
</script>

<h1>Coming up</h1>

<div class="gigs flex">
  {#each upcoming as gig}
    <Gig {gig} />
  {/each}
  <div class="item-6 md:item-4">
    <div class="soon">
      Coming soon
    </div>
  </div>
</div>

<h1>Past</h1>

{#each past as gig}
  <Gig {gig} />
{:else}
  Nothing in the past.
{/each}

<style>
.gigs {
}
.soon {
  padding-top: 50%;
  text-align: center;
  width: 100%;
  height: 100%;
  color: #888;
  border: 3px dashed rgba(0,0,0,0.3);
}

</style>