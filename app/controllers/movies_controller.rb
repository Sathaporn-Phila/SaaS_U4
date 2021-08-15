class MoviesController < ApplicationController
  def show
    @movie = Movie.find_by_id(params[:id]) # what if this movie not in DB?
    # BUG: we should check @movie for validity here!
  end
  def new
    # default: render 'new' template
  end
  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end
  private
    def movie_params
      params.require(:movie).permit(:title, :rating, :release_date)
    end
end
