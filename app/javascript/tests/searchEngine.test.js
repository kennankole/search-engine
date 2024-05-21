
import { logArticleQuery, setUpEventListeners } from "tests";


global.fetch = jest.fn(() => Promise.resolve({
  json: () => Promise.resolve({status: 'success'})
}));

describe('logArticleQuery', () => {
  beforeEach(() => {
    fetch.mockClear();
  });

  it('logs the query to the server', async () => {
    const csrfToken = 'dummy-csrf-token';
    const query = 'test query';

    await logArticleQuery(query, csrfToken);

    expect(fetch).toHaveBeenCalledWith('/article_query_logs', {
      methods: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': csrfToken
      },
      body: JSON.stringify({
        search_log: { query: query }
      })
    });
  });
});

