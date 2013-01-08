class ReviewsController < ApplicationController
  def show
    @artists = Artist.all
    @reviews = Review.all
    
    respond_to do |format|
      format.html # show.html.haml
      format.xml { render :xml => @reviews }
    end
  end
end
