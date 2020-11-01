<script>
import Gig from 'components/gig.svelte'
import { Inertia } from '@inertiajs/inertia'
import { page } from 'inertia-svelte'
import { stringify } from 'querystring'
import { onMount } from 'svelte'
export let user
export let gigs

function saveICS() {
  Inertia.reload({method: 'PUT', data: {user: {ics_url: user.ics_url}}})
}

onMount(function() {
  new Twitch.Embed("embed", {
    width: '100%',
    height: '100%',
    channel: user.name,
    // only needed if your site is also embedded on embed.example.com and othersite.example.com 
    parent: ["newsoundforjapan.com", "localhost"]
  });
})

</script>


{#if $page.current_user && $page.current_user.id == user.id && !$page.current_user.ics_url}
  <h1>Please let our visitors know your DJ schedule.</h1>
  Paste the URL to an .ics calendar file (eg. from Google Calendar).
  We will import gigs from the .ics file and promote them on our website.<br>
  <input type="text" bind:value={user.ics_url}><button on:click={saveICS}>Submit</button><br>
{:else}
  <div class="user_header">
    <img class="profile_image" src={user.profile_image} alt={user.display_name}>
    <h2>{user.display_name}</h2>
    <p>{user.description}</p>
  </div>
  <div id="twitch"><div id="embed"></div></div>
  <h3>Upcoming Shows</h3>

  <div class="gigs flex">
    {#each gigs as gig}
      <Gig {gig} />
    {:else}
      No upcoming gigs.
    {/each}
  </div>
{/if}

<style>
#twitch {
  width: 100%;
  padding-bottom: 44%;
  position: relative;
}
#embed {
  position: absolute;
  width: 100%;
  height: 100%;
}
.user_header {
  padding: 30px 0;
  height: 150px;
}
.profile_image {
  float: left;
  height: 100px;
  margin-right: 30px;
}
</style>