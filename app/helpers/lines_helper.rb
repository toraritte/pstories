module LinesHelper
  def story_item?(line)
    line.plot_item ? true : false
  end

  def story_item(line)
    story_item?(line) ? line.plot_item : line.dialogue_item
  end
end
