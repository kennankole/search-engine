class ArticleQueryLogsController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    @search_log = ArticleQueryLog.new(search_params)
    @search_log.ip = request.remote_ip

    if @search_log.save
      render json: {
        status: 'Success'
      }, status: :created
    else
      render json: {
        errors: search_log.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def index
    # @search_logs = ArticleQueryLog.all
    @search_trends = ArticleQueryLog.all
  end

  private

  def search_params
    params.require(:search_log).permit(:query)
  end

  def summarize_searches
    logs = ArticleQueryLog.order(:ip, :created_at).pluck(:ip, :query)
    grouped_searches = logs.group_by { |ip, _| ip }
    summarized_searches = grouped_searches.transform_values do |queries|
      queries.map(&:last).chunk_while { |i, j| i != j }.map(&:last).uniq
    end
    summarized_searches.values.flatten.tally
  end
end
