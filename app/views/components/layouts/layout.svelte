<script>
  import { inertia } from 'inertia-svelte'
  import currentUser  from 'user'
</script>

<div class="container">
  <header>
    <a use:inertia href="/">
      <img class="logo" src={require('images/logo.png').default}/>
    </a>
    {#if $currentUser}
      <div class="logout">
        Welcome, {$currentUser.name}
        <a use:inertia={{method: 'DELETE'}} href="/session">Log out</a>
      </div>
    {/if}
  </header>
  
  <div class="splash">
    <p>
      All our events feature an open DJ booth. We provide the equipment, you provide the vibes.<br>
      To reserve a DJ timeslot, all you have to do is log in with Twitter and click on the "Reserve DJ slot" button.
    </p>
  </div>
  

  <slot />

  <footer>
    All times are in JST (Asia/Tokyo)<br><br>
    Copyright © 2020 STEFAN K.K., All Rights Reserved | <a use:inertia href="/covid19">COVID-19 Information</a> | <a use:inertia href="/privacy_policy">Privacy Policy</a>
    
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
/* .container {
  position: relative;
  margin: 0 auto;
  width: 100%;
}
@media screen and (min-width: 1022px) {
  .container {
    margin: 0 auto;
    width: 1022px;
  }
} */

</style>
