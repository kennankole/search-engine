document.addEventListener('DOMContentLoaded', () => {
  const searchInput = document.getElementById('search-input');
  const searchResults = document.getElementById('search-results');

  const logArticleQuery = (query) => {
    fetch('/article_query_logs', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('[name=csrf-token]').content
      },
      body: JSON.stringify({
        search_log: { query: query }
      })
    })
    .then(response => response.json())
    .then(data => {
      if (data.status === 'success') {
        console.log('Search query logged:', query);
      }
    });
    searchResults.innerHTML = `You searched for: ${query}`;
  }

  // Record complete Search engine user query
  searchInput.addEventListener('keypress', (event) => {
    if (event.key === 'Enter') {
      const query = event.target.value.trim();
      if (query) {
        logArticleQuery(query);
      }
    }
  // Realtime Search engine recordig of user query
  searchInput.addEventListener('input', (event) => {
    const queryContent = event.target.value.trim();
    searchResults.innerHTML = `You searched for: ${queryContent}`;
  })
  });
});