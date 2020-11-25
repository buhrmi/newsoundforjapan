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
  <h2>Upcoming Gigs</h2>

  <div class="gigs flex">
    {#each gigs as gig}
      <Gig {gig} />
    {:else}
    <div class="gig">
      No upcoming gigs.

    </div>
    {/each}
  </div>

  <h2>Listen</h2>
  <div class="soundcloud">
    {#if user.soundcloud_playlist_id}
      <iframe width="100%" height="300" scrolling="no" frameborder="no" allow="autoplay" src="https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/playlists/{user.soundcloud_playlist_id}&color=%23bf25b6&auto_play=false&hide_related=true&show_comments=true&show_user=true&show_reposts=false&show_teaser=true&visual=true"></iframe>
    {:else}
      We currently don't have a playlist for this user.  
    {/if}
    </div>
  <div id="twitch"><div id="embed"></div></div>

  
{/if}

<style>
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