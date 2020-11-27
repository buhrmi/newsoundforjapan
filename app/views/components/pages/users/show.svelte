<script>
import Gig from 'components/gig.svelte'
import { Inertia } from '@inertiajs/inertia'
import { page, inertia } from 'inertia-svelte'
import { stringify } from 'querystring'
import { onMount } from 'svelte'
import formatTime from 'format_time'
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
  <h1>
    {user.display_name}
    <a target="_blank" href="https://twitter.com/{user.twitter_name}">Show on Twitter</a>
  </h1>
  <p>
    {user.description}<br>
  </p>
</div>

<h2>Upcoming Gigs</h2>

  {#each gigs as gig}
    <div class="gig">
    {formatTime(gig.start_at)}<br>
    <strong><a use:inertia href="/events/{gig.event.id}">{gig.event.name}</a></strong>
  </div>
  {:else}
  <div class="gig">
    No upcoming gigs listed.
  </div>
  {/each}

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
strong {
  font-size: 1.5em;
}
h1 a {
  font-size: 0.5em;
}
</style>