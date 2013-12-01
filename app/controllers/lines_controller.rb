class LinesController < ApplicationController
  helper LinesHelper

  def index
    @story = Story[params[:story_id]]
  end

  def edit
    @story = Story[params[:story_id]]
    @line = @story.lines_dataset.first(id: params[:id])
  end

  def update
    @story = Story[params[:story_id]]
    @line = @story.lines_dataset.first(id: params[:id])
    @line.character.update(params[:character].permit(:name))
    @line.update(params[:line].permit(:plot_item,:dialogue_item))
    redirect_to story_lines_path(@story)
  end

  def create
  end

end
