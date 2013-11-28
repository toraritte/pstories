class StoriesController < ApplicationController

  def index
    @stories = Story.all
  end

  def show
    @story = Story[params[:id]]
  end

end
