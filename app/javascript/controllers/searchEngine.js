export const logArticleQuery = async (query, csrfToken) => {
  const response = await fetch('/article_query_logs', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': csrfToken
    },
    body: JSON.stringify({
      search_log: { query: query }
    })
  });
  const data = await response.json();
  if (data.status === 'success') {
    console.log('Search query logged:', query);
  }
};

export const setUpEventListeners = (searchInput, searchResults, csrfToken) => {
  searchInput.addEventListener('keypress', (event) => {
    if (event.key === 'Enter') {
      const query = event.target.value.trim();
      if (query) {
        logArticleQuery(query);
      }
    }
  });

  searchInput.addEventListener('input', (event) => {
    const queryContent = event.target.value.trim();
    searchResults.innerHTML = `You searched for: ${queryContent}`;
  });
};

document.addEventListener('DOMContentLoaded', () => {
  const searchInput = document.getElementById('search-input');
  const searchResults = document.getElementById('search-results');
  const csrfToken = document.querySelector('[name=csrf-token]').content
  setUpEventListeners(searchInput, searchResults, csrfToken);
});