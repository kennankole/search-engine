document.addEventListener('DOMContentLoaded', () => {
  alert('Hello')
  fetch('/dashboard', {
    method: 'GET',
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': document.querySelector('[name=csrf-token').content
    }
  })
    .then(response => response.json())
    .then(data => {
      const searchTrendsList = document.getElementById('search-trends');
      const rankedKeywordsTable = document.getElementById('ranked-keywords');

      rankedKeywordsTable.innerHTML = '';
      searchTrendsList.innerHTML = '';

      Object.keys(data).forEach(keyword => {
        const listItem = document.createElement('li');
        listItem.textContent = `${keyword}: ${data[keyword].queries}`;
        searchTrendsList.appendChild(listItem);

        const tableRow = document.createElement('tr');
        const keywordCell = document.createElement('td');
        const countCell = document.createElement('td');
        const queriesCell = document.createElement('td');

        keywordCell.textContent = keyword;
        countCell.textContent = data[keyword].count;

        const queryList = document.createElement('ul');
        data[keyword].queries.forEach(query => {
          const queryItem = document.createElement('li');
          queryItem.textContent = query;
          queryList.appendChild(queryItem);
        });

        queriesCell.appendChild(queryList);
        tableRow.appendChild(keywordCell);
        tableRow.appendChild(countCell);
        tableRow.appendChild(queriesCell);
        rankedKeywordsTable.appendChild(tableRow);
      });
    })
    .catch(error => console.error('Error fetching searching trends:', error));
});
