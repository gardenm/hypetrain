class ReviewsController < ApplicationController
  def show
    @albums = Album.all :order => 'updated_at DESC'
    @reviews = Review.all :order => 'updated_at DESC'
    
    respond_to do |format|
      format.html # show.html.haml
      format.xml { render :xml => @reviews }
    end
  end
end
