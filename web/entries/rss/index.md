<set- rss="load('./rss.mts')" />

# Portland RSS

A homepage for local resources about RSS

### What? And Why RSS?

RSS is simple technology which stands the test of time. RSS is a feed, just like
on Facebook or Instagram, but not owned by any gross company. In fact, it's not
owned by anyone at all! Anyone can make an RSS feed and anyone can see them.

All you have to do is get an app called an RSS reader.

We want to encourage all local businesses to publish a feed. Have daily specials? Do people call you for urgent updates? These and many more are great reasons for a feed.

### Resources

<link href="https://cdn.jsdelivr.net/npm/simple-datatables@10.0/dist/style.css" rel="stylesheet" type="text/css">
<script src="https://cdn.jsdelivr.net/npm/simple-datatables@10.0" type="text/javascript"></script>

<style>
  table details {
    padding-block-end: 0;
    background: unset;
    border: none;
    summary {
      font-weight: normal;
      white-space: wrap;
    }
    &:not([open]) summary {
      max-width: 20ch;
      overflow: hidden;
      white-space: nowrap;
      text-overflow: ellipsis;
    }
  }
</style>
<table rss-resources>
  <thead>
    <tr>
      <th>Name</th>
      <th>Description</th>
      <th>Homepage</th>
      <th>Feed URL</th>
      <th>Tags</th>
    </tr>
  </thead>
  <tbody>
    <render- map="rss.resources">
      <tr>
        <td x-content="item.name" />
        <td>
          <details><summary x-content="item.desc" /></details>
        </td>
        <td>
          <a x-href="item.pageUrl">home</a>
        </td>
        <td>
          <r- if="item.feedUrl">
            <a x-href="item.feedUrl">feed</a>
          </r->
        </td>
        <td x-content="item.tags" />
      </tr>
    </render->
  </tbody>
</table>

<a href="./resources.md">See the full list</a>

### Wishlist

Wouldn't it be cool to have a list of local humans who have RSS feeds? Like [this one for `/now` pages](https://nownownow.com/US-OR).

Wouldn't it _also_ be cool to have all these RSS feeds on a map, e.g. a business next to its feed?? Food for thought in the future.

How about if your favorite restaurant down the street had a feed for their daily specials?

Oh, and what about if _this page_ had an RSS feed?! That way, you'd hear when it gets updated. It's kinda silly it doesn't, yet.

And here's more resources we wish had RSS feeds:

<table rss-wishlist>
  <thead>
    <tr>
      <th>Name</th>
      <th>Description</th>
      <th>Homepage</th>
      <th>Tags</th>
    </tr>
  </thead>
  <tbody>
    <render- map="rss.wishlist">
      <tr>
        <td x-content="item.name" />
        <td x-content="item.desc" />
        <td>
          <a x-href="item.pageUrl">home</a>
        </td>
        <td x-content="item.tags" />
      </tr>
    </render->
  </tbody>
</table>

<script type="module">
const { DataTable } = simpleDatatables;
new DataTable('table[rss-resources]', { perPage: 7 })
new DataTable('table[rss-wishlist]', { perPage: 7 })
</script>
