<set- rss="load('./rss.mts')" />

# Portland RSS Resources

<link href="https://cdn.jsdelivr.net/npm/simple-datatables@10.0/dist/style.css" rel="stylesheet" type="text/css">
<script src="https://cdn.jsdelivr.net/npm/simple-datatables@10.0" type="text/javascript"></script>

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
        <td x-content="item.desc" />
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

<script type="module">
const { DataTable } = simpleDatatables;
new DataTable('table[rss-resources]', { paging: false })
</script>
