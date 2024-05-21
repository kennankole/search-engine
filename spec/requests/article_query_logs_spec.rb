require 'rails_helper'

RSpec.describe "ArticleQueryLogs", type: :request do
  describe "POST #create" do
    context 'with valid parameters' do
      let(:valid_attributes) { { search_log: { query: 'Testing search engine' } } }

      it 'creates a new ArticleQueryLog' do
        expect {
          post '/article_query_logs', params: valid_attributes
        }.to change(ArticleQueryLog, :count).by(1)
      end

      it 'returns a success response' do
        post article_query_logs_path, params: valid_attributes
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['status']).to eq('Success')
      end
    end

    context 'with invalid parameters' do
      let(:invalid_attributes) { { search_log: { query: '' } } }
      it 'does not create a new ArticleQueryLog' do
        post article_query_logs_path, params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['errors']).to eq(["Query can't be blank"])
      end
    end
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get article_query_logs_index_path
      expect(response).to be_successful
    end
  end
end
