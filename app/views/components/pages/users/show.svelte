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


<div class="user_header">
  <img class="profile_image" src={user.profile_image} alt={user.display_name}>
  <h1>{user.display_name}</h1>
  <p>{user.description}</p>
</div>
<h2>Upcoming Gigs</h2>

<div class="gigs flex">
  {#each gigs as gig}
    <Gig {gig} />
  {:else}
  <div class="gig">
    No upcoming gigs listed.
  </div>
  {/each}
</div>

<h2>Listen</h2>
<div class="soundcloud">
  {#if user.soundcloud_playlist_id}
    <iframe width="100%" height="300" scrolling="no" frameborder="no" allow="autoplay" src="https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/playlists/{user.soundcloud_playlist_id}&color=%23bf25b6&auto_play=false&hide_related=true&show_comments=true&show_user=true&show_reposts=false&show_teaser=true&visual=true"></iframe>
  {:else}
    We currently don't have a playlist. Please check back later.
  {/if}
  </div>
<div id="twitch"><div id="embed"></div></div>


{#if !$page.current_user}
  <div class="claim">
  <b>Is this you?</b> Log in with Twitter to make changes and start accepting gigs.<br><br>
  <a href="/auth/twitter?return_to={encodeURIComponent(window.location)}" class="btn-big">
    <span class="sc-text">
      Log in with Twitter
    </span> 
  </a>
</div>
  {/if}

<style>
.claim {
  margin-top: 40px;
  background: rgba(255, 255, 255, 0.03);
  padding: 20px;
}
.user_header {
  padding: 20px 0;
  height: 170px;
}
h1 {
  margin-top: 10px;
  margin-bottom: 0px;
}
.profile_image {
  float: left;
  height: 120px;
  margin-right: 30px;
}
</style>