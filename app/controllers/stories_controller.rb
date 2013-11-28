class StoriesController < ApplicationController

  def index
    @stories = Story.all
    @story = Story.new
  end

  def show
    @story = Story[params[:id]]
  end

  def create
    @story = Story.new( story_params )
    if @story.save
      redirect_to story_item_story_path(@story.id)
    end
  end

  private

    def story_params
      params.require(:story).permit(:title)
    end

end
