module LinesHelper
  def story_item?(line)
    line.plot_item ? true : false
  end

  def story_item(line)
    story_item?(line) ? :plot_item : :dialogue_item
  end
end
