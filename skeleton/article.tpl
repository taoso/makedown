<!doctype html>
<html lang="en">
  <head>
    ${ head.tpl() }
  </head>
  <body>
    <article>
      <h1>$title$</h1>
      <a rel="author" href="$author_url$">$author_name$</a>
      <date>$date$</date>
      <span>⏳$read_time$ min($runes$k words)</span>
      $if(toc)$
      <nav id="TOC" role="doc-toc">
      $table-of-contents$
      </nav>
      $endif$
      $body$
    </article>
    <footer>
    ${ footer.tpl() }
    </footer>
  </body>
</html>
