class CategoriesController < ApplicationController

  before_action :require_admin, except: [:index, :show]

  def index
    @categories = Category.paginate(page: params[:page], per_page: 5)
  end

  def show
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to @category, notice: "Category was created Successfully"
    else
      render 'new'
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  private

  def require_admin
    if !(logged_in? && current_user.admin?)
      redirect_to categories_path, alert: "Only Admins are allowed to create categories"
    end
  end
end