<script>
  import { inertia } from 'inertia-svelte'
  import currentUser  from 'user'
</script>

<div class="container">
  {#if $currentUser}
    <div>
      Welcome, {$currentUser.name}
    
      <div class="logout">
        <a use:inertia={{method: 'DELETE'}} href="/session">Log out</a>
      </div>
    </div>
  {:else}
    <h1><a use:inertia href="/">New Sound For Japan <span>Alpha</span></a></h1>
  {/if}

  <slot />

  <footer>
    Copyright 2020 New Sound For Japan K.K. | <a use:inertia href="/privacy_policy">Privacy Policy</a>
  </footer>
</div>

<style>
.top {
  height: 100px;
}
.character_overview {
  position: absolute;
  width: 100%;
}
.portrait {
  position: relative;
  height: 90px;
  width: 90px;
  border: 1px solid black;
  border-radius: 100px;
  overflow: hidden;
}
.name {
  position: absolute;
  left: 100px;
  top: 15px;
}
.hpbar {
  width: 170px;
  height: 18px;
  border: 1px solid black;
  color: white;
  position: absolute;
  top: 35px;
  left: 95px;
  text-align: center;
}
.hpbar .fill {
  position: absolute;
  height: 100%;
  background-color: #cc2222;
  z-index: -1;
}

.level {
  position: absolute;
  border: 1px solid black;
  border-radius: 30px;
  height: 25px;
  width: 25px;
  text-align: center;
  line-height: 25px;
  font-weight: bold;
  top: 0px;
  left: 70px;
  background: white;
}
.logout {
  position: absolute;
  right: 0;
}
.coin {
  position: absolute;
  left: 100px;
  top: 65px;
}
.honor {
  position: absolute;
  left: 180px;
  top: 65px;
}

h1 span {
  font-size: 0.5em;
  font-weight: normal;
}

h1 a {
  color: black !important;
  text-decoration: none !important;
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