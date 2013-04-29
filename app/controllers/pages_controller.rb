require 'net/http'
require 'csv'
require 'statsample'

class PagesController < ApplicationController
  def home

  end
  
  def reset
    Listing.reset_regression
    @message = "regression reset!"
    render 'dbadmin'
  end
  
  def sort
    @recommendations = Listing.order(:price)
  end
  
  def update    
    @message = Listing.calculate_regression
    render 'dbadmin'
  end
  
  def dbadmin
    if params[:password] == "password"
      render 'dbadmin'
    else
      @error = "wrong password!"
      render 'db'
    end
  end
  
  def loaddb
    Listing.import_data(params[:import_csv][:csv].read)
    
    @message = "db updated!"
    render 'dbadmin'
  end
  
  def resetdb
    Listing.delete_all
    @message = "db deleted :("
    render 'dbadmin'
  end
  
  def viewdb
    params = {:p => "success"}
    redirect_to 'listings/index'
  end
  
  def result
    if params[:sort] != "minutes"
      address = params[:address]
      price = params[:price]
      bedrooms = params[:bedrooms]    
      @results = Listing.new_data(address, price, bedrooms)
    
      @recommendations = Listing.order(:price)
      @recommendations = Listing.where("price < ? OR minutes <= ?", @results[:price], @results[:minutes]).select('address, bedrooms, minutes, price')
      @recommendations = @recommendations.take(10)
    end
  end
end