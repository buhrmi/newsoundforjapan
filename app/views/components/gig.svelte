<script>
import { inertia } from 'inertia-svelte'
import formatTime from 'format_time'
export let gig
</script>

<div class="gig item-6 md:item-4">
  <a use:inertia href="/{gig.talent.twitter_name}">
    <!--div class="time">
      {formatTime(gig.start_at)}
    </div-->
    <div class="talent_profile_image">
      <img src={gig.talent.profile_image}>
    </div>
    <div class="details">
      <div class="name">
        {gig.talent.display_name}
      </div>
      <div class="event">
        {gig.event.name}
      </div>
      {#if gig.summary}
        <div class="summary">
          {gig.summary}
        </div>
      {/if}
    </div>
  </a>
</div>

<style>
  .details {
    background-color: rgba(0,0,0,0.6);
    width: 100%;
    bottom: 0;
    color: white;
  }
  .gig {
    transition: all 0.3s;
    position: relative;
  }
  .gig:hover {
    transform: scale(1.05);
  }
  .details {
    padding: 8px;
    position: absolute;
  }
  .time {
    padding-bottom: 3px;
  }
</style>
