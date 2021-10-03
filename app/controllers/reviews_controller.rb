class ReviewsController < ApplicationController
    before_action :has_moviegoer_and_movie, :only => [:new, :create, :edit]

    protected

    def has_moviegoer_and_movie
      unless @user
        flash[:warning] = 'You must be logged in to create a review.'
        redirect_to movies_path
      end
      unless (@movie = Movie.find_by_id(params[:movie_id]))
        flash[:warning] = 'Review must be for an existing movie.'
        redirect_to movies_path
      end
    end

    public

    def new
      @review = @movie.reviews.build
    end
    
    def create
      @user.reviews << @movie.reviews.build(review_params)
      redirect_to movie_path(@movie)
    end

    def edit 
      @movie = Movie.find params[:movie_id]
      @review = Review.find_by(movie_id:@movie.id, user_id:@user.id)
    end

    def update
      @movie = Movie.find params[:movie_id]
      @review = Review.find_by(movie_id:@movie.id, user_id:@user.id)
      @review.update(review_params)
      flash[:notice] = "Your review was successfully updated."
      redirect_to movie_path(@movie)
    end

    def destroy
      @movie = Movie.find params[:movie_id]
      @review = Review.find_by(movie_id:@movie.id, user_id:@user.id) 
      @review.destroy
      flash[:notice] = "Your review deleted."
      redirect_to movie_path(@movie)
    end

    private

    def review_params
      params.require(:review).permit(:potatoes, :comments, :movie_id, :user_id)
    end  
end