class ActivityCategoriesController < ApplicationController
  before_action :set_activity_category, only: [:show, :update, :destroy]

  def index
    @activity_categories = ActivityCategory.all
  end
  
  def create
    @activity_category = ActivityCategory.new(activity_category_params)
    if @activity_category.save
      render json: @activity_category
    else
      render json: @activity_category.errors, status: :unprocessable_entity
    end
  end

  def show
  end

  def update
    if @activity_category.update(activity_category_params)
      render :show, status: :ok, location: @activity_category
    else
      render json: @activity_category.errors, status: :unprocessable_entity
    end
  end 

  def destroy
    @activity_category.destroy
  end

  private 

  def set_activity_category
    @activity_category = ActivityCategory.find(params[:id])
  end

  def activity_category_params
    params.require(:activity_category).permit(:title, :description, :lat, :long, :photo_url, :additional_info, :group_id)
  end
end
