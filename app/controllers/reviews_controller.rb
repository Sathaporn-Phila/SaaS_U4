class ReviewsController < ApplicationController
    before_action :has_moviegoer_and_movie, :only => [:new, :create, :edit, :update]
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

    def review_params
      params.require(:review).permit(:potatoes, :comments, :movie_id, :user_id)
    end
    
    public
    def new
      @review = @movie.reviews.build
    end
    def create
      # since moviegoer_id is a protected attribute that won't get
      # assigned by the mass-assignment from params[:review], we set it
      # by using the << method on the association.  We could also
      # set it manually with review.moviegoer = @user.
      @user.reviews << @movie.reviews.build(review_params)
      redirect_to movie_path(@movie)
    end

    def edit
      @review = Review.find_by_id(params[:movie_id])
      @review = Review.find_by_id(params[:user_id])
    end
     
    def update
      @review = Review.find_by_id(params[:movie_id])
      @review = Review.find_by_id(params[:user_id])
      if @review.update(review_params)
        flash[:notice] = "Your review was successfully updated."
        redirect_to movie_path(@movie)
      else
        render 'edit' # note, 'edit' template can access @movie's field values!
      end
    end

    def destroy
      @review = Review.find_by_id(params[:movie_id])
      @review = Review.find_by_id(params[:user_id])
      @review.destroy
      flash[:notice] = "Your review deleted."
      redirect_to movies_path(@movie)
    end
    
end