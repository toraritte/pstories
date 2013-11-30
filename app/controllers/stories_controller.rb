class StoriesController < ApplicationController

  def index
    @stories = Story.all
    @story = Story.new
  end

  def create
    @story = Story.new( story_params )
    if @story.save
      redirect_to story_lines_path(@story.id)
    end
  end

  def destroy
    @story = Story[ params[:id] ]
    @story.lines_dataset.destroy
    @story.remove_all_characters
    @story.destroy
    redirect_to root_url
  end

  private

    def story_params
      params.require(:story).permit(:title)
    end

end
