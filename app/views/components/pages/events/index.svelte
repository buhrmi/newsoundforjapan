<script>
  import Gig from 'components/gig.svelte'
  import formatTime from 'format_time'
  export let upcoming
  export let past
  </script>
  
  <h1>Coming up</h1>
  {#each upcoming as event}
    <h2>
      {event.name}<br>
      <span class="time">{formatTime(event.start_at)} @ {event.place.name}</span>
    </h2>
    <div class="gigs flex">
      {#each event.gigs as gig}
        <Gig {gig} />
      {/each}
    </div>    
  {/each}
  
  <h1>Past</h1>

  {#each past as event}
    <h2>
      <span class="time">{formatTime(event.start_at)}</span><br>
      {event.name}
    </h2>
    <div class="gigs flex">
      {#each event.gigs as gig}
        <Gig {gig} />
      {/each}
    </div>    
  {/each}

  <style>
  .gigs {
  }
  .time {
    font-size: 0.8em;
    font-weight: normal;
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