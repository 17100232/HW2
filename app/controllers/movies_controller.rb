class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    if params[:sort_by] == 'release_date'
      @movies = Movie.order('release_date') #find(:all, :order => params[:sort_by])
      @title_header = "hilite"
    elsif params[:sort_by] == 'title'
      @movies = Movie.order('title')
      @title_header = "hilite"
    else
      @movies = Movie.all
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end
  
  def update_existing
    
  end
  
  def update_existing_helper
    @movie = Movie.find_by_title(params[:movie][:title_old])
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movies_path
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end
  
  def destroy_by_title
    
  end
  
  def destroy_by_rating
    
  end
  
  def deleteByTitle
    @movie = Movie.find_by_title(params[:movie][:title_old])
    if @movie
      @movie.destroy
      flash[:notice] = "Movie '#{@movie.title}' deleted."
    end
    redirect_to movies_path
  end
  
  def deleteByRating
    @movie = Movie.where(:rating => params[:movie][:rating])
    if @movie
      @movie.each do |iter|
          iter.destroy
      end
      flash[:notice] = "Movie(s) with rating '#{params[:rating]}' deleted."
    end  
    redirect_to movies_path
  end
  


end
