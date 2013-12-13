class LinesController < ApplicationController

  def index
    @story = Story[params[:story_id]]
    @line = Line.new
  end

  def edit
    @story = Story[params[:story_id]]
    @line = @story.lines_dataset.first(id: params[:id])
    @line_type = if @line.character_id
                   'Dialogue'
                 else
                   'Plot'
                 end
  end

  def update
    @story = Story[params[:story_id]]
    @line = @story.lines_dataset.first(id: params[:id])
    @line.character.update(params[:character].permit(:name))
    @line.update(params[:line].permit(:plot_item,:dialogue_item))
    redirect_to story_lines_url(@story)
  end

  def create
    @story = Story[params[:story_id]]
    # TODO[8] - not checking capitalization errors
    @character_id = unless params[:name].empty?
                   Character.find_or_create( name: params[:name]).id
                 else
                   nil
                 end
    # TODO[7] - once TODO[6] returns an object this whole mess can be made safe
    @line = Line.new(line_item: params[:line_item],
                     sequence: Line.seq,
                     character_id: @character_id)
    @story.add_line @line
    @story.add_character Character[@character_id] if @character_id
    redirect_to story_lines_url(@story)
  end

end
