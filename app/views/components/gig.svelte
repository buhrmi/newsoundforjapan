<script>
import formatTime from 'format_time'
export let gig
</script>

<a href="/users/{gig.talent_id}">
  <div class="gig">
    {gig.summary}<br>
    {formatTime(gig.start_at)}
  </div>
</a>

<style>
  .gig {
    border: 1px solid #444;
    padding: 15px;
    margin-bottom: 12px;
  }
</style>
