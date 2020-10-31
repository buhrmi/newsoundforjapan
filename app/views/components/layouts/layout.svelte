<script>
  import { inertia } from 'inertia-svelte'
  import currentUser  from 'user'
</script>

<div class="container">
  <header>
    <a use:inertia href="/">
      <img class="logo" src={require('images/logo.png').default}/>
    </a>
  </header>
  
  {#if $currentUser}
    <div>
      Welcome, {$currentUser.name}
    
      <div class="logout">
        <a use:inertia={{method: 'DELETE'}} href="/session">Log out</a>
      </div>
    </div>
  {/if}

  <slot />

  <footer>
    All times are in Asia/Tokyo<br><br>
    New Sound For Japan is a collective of Twitch streamers and DJs united by one goal:<br>
    Discover the ultimate sound and bring it to Japan.<br><br>
    Copyright 2020 New Sound For Japan K.K. | <a use:inertia href="/privacy_policy">Privacy Policy</a> | <a use:inertia href="/users/new">Join as Streamer</a>
  </footer>
</div>

<style>
.logo {
  margin-top: 40px;
  width: 460px;
  max-width: 100%;
}
.logout {
  position: absolute;
  right: 0;
}


footer {
  margin-top: 30px;
  padding-top: 10px;
  border-top: 1px solid black;
}
.container {
  position: relative;
  margin: 0 auto;
  width: 100%;
}
@media screen and (min-width: 1022px) {
  .container {
    margin: 0 auto;
    width: 1022px;
  }
}

</style>