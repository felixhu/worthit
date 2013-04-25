require 'net/http'
require 'csv'
class PagesController < ApplicationController
  def home

  end
  
  def sort
    @recommendations = Listing.order(:price)
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
    CSV.parse(params[:import_csv][:csv].read) do |row|
      temp = Listing.new(:address => row[0], :price => row[3], :bedrooms => row[1], :minutes => row[2])
      temp.save
    end
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
    @results = Listing.import_data(address, price, bedrooms)
    
    @recommendations = Listing.order(:price)
    @recommendations = Listing.where(:minutes => 0...@results[:minutes]+5).select('address, bedrooms, minutes, price')
    @recommendations = @recommendations.take(20)
  end

  end
end