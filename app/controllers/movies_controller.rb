class MoviesController < ApplicationController
  def index
    @movies = Movie.order(:title).all
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    begin
       @movie = Movie.find(id) # look up movie by unique ID
       # will render app/views/movies/show.html.haml by default
    rescue
      flash[:notice] = "Movie id #{id} not found."
      redirect_to movies_path
    end
   end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to @movie
  end

  def edit
    @movie = Movie.find(params[:id])
  end
   
  def update
      @movie = Movie.find params[:id]
      @movie.update(movie_params)
      flash[:notice] = "#{@movie.title} was successfully updated."
      redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end
  private

    def movie_params
      params.require(:movie).permit(:title, :rating, :release_date)
    end
end
