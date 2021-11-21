class ArticlesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  

  def index
    articles = Article.all.includes(:user).order(created_at: :desc)
    render json: articles, each_serializer: ArticleListSerializer
  end

  def show
   
    article = Article.find(params[:id])
    session[:pageviews] ||= 3
    if session[:pageviews] > 0
      session[:pageviews] -= 1
      render json: article 
   
    else
      render json: {error: "maximum page views reached" }, status: :unauthorized 
  
    end

  end

  private

  def record_not_found
    render json: { error: "Article not found" }, status: :not_found
  end


  

end
