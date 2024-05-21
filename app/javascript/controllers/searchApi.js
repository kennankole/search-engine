import { FetchRequest } from "@rails/request.js";

const searchApi = async (query, searchResults) => {
  console.log('Search API')

  const request = new FetchRequest('post', '/article_query_logs', {
    body: JSON.stringify({ search_log: { query: query }}),
    headers: {
      'Content-Type': 'application/json',
    }
  });

  const response = await request.perform()
  if (response.ok){
    const body = await response.text;
    console.log(body);
  }
  searchResults.innerHTML = `You searched for ${query}`;
}
export default searchApi;
