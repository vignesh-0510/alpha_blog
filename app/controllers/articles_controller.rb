class ArticlesController < ApplicationController

  before_action :set_Article, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:show, :index]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def show

  end

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def new
    @article = Article.new
  end

  def edit

  end

  def create
    @article = Article.new(require_params)
    @article.user = current_user
    if @article.save
      redirect_to @article, notice: "Article was created Successfully."
    else
      render "new"
    end
  end

  def update

    if @article.update(require_params)
      flash[:notice] = "Article was Updated Successfully"
      redirect_to @article
    else
      render "edit"
    end
  end

  def destroy

    @article.destroy
    flash[:notice] = "Article was deleted Successfully."
    redirect_to articles_path
  end

  private

  def set_Article
    @article = Article.find(params[:id])
  end

  def require_params
    params.require(:article).permit(:title, :description)
  end

  def require_same_user
    if current_user != User.find(@article.user_id) && !current_user.admin?
      redirect_to @article, alert: "You can only Edit your own article"
    end
  end

end