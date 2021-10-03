class ReviewsController < ApplicationController
    before_action :has_moviegoer_and_movie, :only => [:new, :create, :edit, :update, :destroy]
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
      # @review = @movie.reviews.build
      @review = Review.new
    end
    def create
      # since moviegoer_id is a protected attribute that won't get
      # assigned by the mass-assignment from params[:review], we set it
      # by using the << method on the association.  We could also
      # set it manually with review.moviegoer = @user.

      # @user.reviews << @movie.reviews.build(review_params)
      # redirect_to movie_path(@movie)

      @review = Review.new(review_params)
      @review.movie_id = @movie.id
      @review.user_id = @user
    end

    def edit
      # @review = Review.find_by_id(params[:movie_id])
    end

    def update
      if @review.update(review_params)
        flash[:notice] = "Your review was successfully updated."
        redirect_to movie_path(@movie)
      else
        render 'edit'
      end
    end

    def destroy
      # @review = Review.find_by_id(params[:movie_id])
      @review.destroy
      flash[:notice] = "Your review deleted."
    end

    private
    def review_params
      params.require(:review).permit(:potatoes, :comments, :movie_id, :user_id)
    end
    def find_movie
      @movie = Movie.find(params[:id])
    end
    def find_review
      @review = Review.find(params[:id])
    end
    
end