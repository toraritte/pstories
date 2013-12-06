class LinesController < ApplicationController

  def index
    @story = Story[params[:story_id]]
    @line = Line.new
  end

  def edit
    @story = Story[params[:story_id]]
    @line = @story.lines_dataset.first(id: params[:id])
    @line_type = @line.plot.to_s.split('_').first
  end

  def update
    @story = Story[params[:story_id]]
    @line = @story.lines_dataset.first(id: params[:id])
    @line.character.update(params[:character].permit(:name))
    @line.update(params[:line].permit(:plot_item,:dialogue_item))
    redirect_to story_lines_url(@story)
  end

  def create
    line_type = params[:line_type]
    @story = Story[params[:story_id]]
    # TODO[8] - not checking capitalization errors
    @character = Character.find_or_create( name: params[:name])
    # TODO[7] - once TODO[6] returns an object this whole mess can be made safe
    # TODO[8] - duplicate code everywhere
    @line = Line.new(dialogue_item: params[:line_item],
                     sequence: Line.seq,
                     character_id: @character.id)
    @story.add_line @line
    @story.add_character @character
    redirect_to story_lines_url(@story)
  end

end
