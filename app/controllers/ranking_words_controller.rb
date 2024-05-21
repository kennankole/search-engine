class RankingWordsController < ApplicationController
  def index
    queries = ArticleQueryLog.all.map(&:query)
    rank_keywords_service = RankKeywords.new(queries)
    rank_keywords_service.rank_keywords
    @ranked_keywords = rank_keywords_service.keyword_data
  end
end
