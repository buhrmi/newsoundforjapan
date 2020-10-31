<script>
  import { inertia } from 'inertia-svelte'
  import currentUser  from 'user'
</script>

<div class="container">
  <img class="logo" src={require('images/logo.png').default}/>
  
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
    Copyright 2020 New Sound For Japan K.K. | <a use:inertia href="/privacy_policy">Privacy Policy</a>
  </footer>
</div>

<style>
.logo {
  width: 200px;
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