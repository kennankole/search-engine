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
        errors: @search_log.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def index
    @search_trends = ArticleQueryLog.all
    render json: @search_trends
  end

  private

  def search_params
    params.require(:search_log).permit(:query)
  end
end
