require 'rails_helper'

RSpec.describe "RankingWords", type: :request do
  describe "GET /index" do
    before do
      ArticleQueryLog.create!(query: 'The quick brown fox jumps over the lazy dog', ip: '127.0.0.1')
      ArticleQueryLog.create!(query: 'Quick brown fox', ip: '127.0.0.1')
      ArticleQueryLog.create!(query: 'Lazy dog and quick fox', ip: '127.0.0.1')
      ArticleQueryLog.create!(query: 'The quick brown fox', ip: '127.0.0.1')
    end

    it 'assigns ranked keywords to @ranked_keywords' do
      get dashboard_path
      json_response = JSON.parse(response.body)
      expect(json_response.size).to eq(7) #quick, brown, fox, jumps, over, lazy, dog
    end
  end
end
