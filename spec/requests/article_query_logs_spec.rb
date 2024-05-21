require 'rails_helper'

RSpec.describe "ArticleQueryLogs", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get "/article_query_logs/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /index" do
    it "returns http success" do
      get "/article_query_logs/index"
      expect(response).to have_http_status(:success)
    end
  end

end
