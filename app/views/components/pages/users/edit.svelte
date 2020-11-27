<script>
import { inertia } from 'inertia-svelte'

</script>

<h1>Update Profile</h1>

Your name, profile image and description are taken from Twitter. To make updates, change it on Twitter and click the button below.<br><br>

<a class="btn-big" use:inertia={{method: 'PUT'}} href='/users/me'>
  <span class="sc-text">
    Fetch from Twitter
  </span> 
</a>
