class BookmarksController < ApplicationController
  before_action :set_list, only: [:new, :create, :index]
  before_action :set_bookmark, only: [:destroy]

  def index
    @bookmarks = @list.bookmarks
  end

  def new
    @bookmark = @list.bookmarks.build
  end

  def create
    @bookmark = @list.bookmarks.build(bookmark_params)
    @bookmark.movie.update(rating: params[:bookmark][:rating]) # Update movie rating
    if @bookmark.save
      redirect_to @list, notice: 'Bookmark was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @bookmark.destroy
    redirect_to @bookmark.list, notice: 'Bookmark was successfully destroyed.'
  end

  private

  def set_list
    @list = List.find(params[:list_id])
  end

  def set_bookmark
    @bookmark = Bookmark.find(params[:id])
  end

  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id)
  end
end
