class RankingWordsController < ApplicationController
  def index
    queries = ArticleQueryLog.all.map(&:query)
    ranker = RankKeywords.new(queries)
    ranker.rank_keywords
    @ranked_keywords = ranker.keyword_data
  end
end
