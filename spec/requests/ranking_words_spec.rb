require 'rails_helper'

RSpec.describe 'RankingWords', type: :request do
  describe 'GET /index' do
    it 'assigns ranked keywords to @ranked_keywords' do
      queries = ['query1', 'query2', 'query3']
      allow(ArticleQueryLog).to receive(:all).and_return(double('ArticleQueryLog', map: queries))

      get dashboard_path
      expect(assigns(:ranked_keywords)).to_not be_nil
    end
  end
end
