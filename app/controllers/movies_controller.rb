class MoviesController < ApplicationController
  def show
    @movie = Movie.find_by_id(params[:id]) # what if this movie not in DB?
    # BUG: we should check @movie for validity here!
  end
  def new
    # default: render 'new' template
  end
end
