<!doctype html>
<html lang="en">
  <head>
    ${ head.tpl() }
  </head>
  <body>
    <header class="index">
     <h1><a href="/">$title$</a></h1>
    </header>
    <ol id="articles" reversed>
$for(articles)$
      <li><a href="$it.path$">$it.title$</a> <date>$it.date$</date></li>
$endfor$
    </ol>
    <footer>
    ${ footer.tpl() }
    </footer>
  </body>
</html>
