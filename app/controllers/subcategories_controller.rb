class SubcategoriesController < ApplicationController
  def index
  end

  def show
  	@category = Category.find_by_name(params[:category_id])
  	@subcategory = @category.subcategories.find_by_name(params[:id]) if @category
  end

end