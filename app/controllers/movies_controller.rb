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
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      flash[:notice] = "#{@movie.title} was successfully created."
      redirect_to movies_path
    else
      render 'new' # note, 'new' template can access @movie's field values!
    end
  end

  def edit
    @movie = Movie.find(params[:id])
  end
   
  def update
    @movie = Movie.find params[:id]
    if @movie.update(movie_params)
      flash[:notice] = "#{@movie.title} was successfully updated."
      redirect_to movie_path(@movie)
    else
      render 'edit' # note, 'edit' template can access @movie's field values!
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end
  private

    def movie_params
      params.require(:movie).permit(:title, :rating, :release_date, :description)
    end
end
