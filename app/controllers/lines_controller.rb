class LinesController < ApplicationController

  helper LinesHelper
  def index
    @story = Story[params[:story_id]]
  end

  def edit
    @story = Story[params[:story_id]]
    @line = @story.lines_dataset.first(id: params[:id])
  end

end
