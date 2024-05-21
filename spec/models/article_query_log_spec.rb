require 'rails_helper'

RSpec.describe ArticleQueryLog, type: :model do
  context 'validates model fields' do
    it 'creates logs search query with valid fields' do
      search_log = ArticleQueryLog.create(
        query: 'Is this a real search engine',
        ip: '127.0.0.1'
      )
      expect(search_log.valid?).to be_truthy
    end

    it 'fails logging search log with invalid fields' do
      search_log = ArticleQueryLog.create(
        query: '',
        ip: ''
      )
      expect(search_log.valid?).not_to be_truthy
    end
  end
end
