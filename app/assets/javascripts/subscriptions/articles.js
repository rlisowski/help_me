App.cable.subscriptions.create({
  channel: "ArticlesChannel"
}, {
  received: function(data) {
    var article_id = data.article_id;

    fetch('/articles/' + article_id,
      {
        headers: {
          'Content-Type': 'text/html',
          'X-Requested-With': 'XMLHttpRequest'
        }
      }
    ).then(
        function(response) {
          if (response.status !== 200) {
            console.log('Looks like there was a problem. Status Code: ' +
              response.status);
            return;
          }

          response.text().then(function(new_article) {
            var article = document.getElementById('article_' + article_id);
            var template = document.createElement('template');
            template.innerHTML = new_article;
            article.parentNode.replaceChild(template.content.firstChild, article);
          });
        }
      )
      .catch(function(err) {
        console.log('Fetch Error :-S', err);
      });
  }
});
