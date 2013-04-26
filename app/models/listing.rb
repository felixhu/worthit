require 'statsample'
require 'csv'
require 'net/http'

class Listing < ActiveRecord::Base
  
  def self.reset_regression
    Regression.create(:constant => 442, 
      :bedroom_coefficient => 515, :minutes_coefficient => 4371)
  end
  
  def self.calculate_regression
    l = Listing.find(:all)
    b = Array.new(l.count).to_scale
    m = Array.new(l.count).to_scale
    p = Array.new(l.count).to_scale
    l.each_with_index do |listing, index|
      b[index] = listing.bedrooms
      m[index] = listing.minutes
      p[index] = listing.price
    end
    ds = {'bedrooms' => b, 'minutes' => m}.to_dataset
    ds['price'] = ds.collect{|row| 442 + 515 * 
      row['bedrooms'] + 4371  * 1 / row['minutes']}
    lr = Statsample::Regression.multiple(ds,'price')
    result = String(lr.summary)
    
    constant = result.split('| Constant | ')[1]
    constant = constant.split(' | ')[0]
    bedroomCoef = result.split('| bedrooms | ')[1]
    bedroomCoef = bedroomCoef.split(' | ')[0]
    minCoef = result.split('minutes ')[-1]
    minCoef = minCoef.split(' | ')[1]
    
    Regression.create(:constant => constant, 
      :bedroom_coefficient => bedroomCoef, :minutes_coefficient => minCoef)
    
    return @result = "price = " + constant + " + " + bedroomCoef + " x (number of bedrooms) + " + 
    minCoef + " x (1 / minutes from Northwestern)"
  end
  
  def self.import_data(csv)    
    CSV.parse(csv) do |row|
      address_arr = row[0].split(' ')[0...2]
      address = String(address_arr.at(0)) + " " + String(address_arr.at(1)).capitalize
      bedrooms = Float(row[1])
      minutes = Integer(row[2])
      estimatedPrice = self.regression_model(bedrooms, minutes)
      price = Integer(row[3])
      
      if minutes > 0 and minutes < 50 and price > 0.3 * estimatedPrice and price < 1.7 * estimatedPrice
        Listing.create(:address => address, :price => price, :bedrooms => bedrooms, :minutes => minutes)
      end
    end
  end
  
  def self.new_data(a, p, b)
    hasAddress = true
    address_arr = a.split(' ')
    if address_arr.include?("minutes") or address_arr.include?("mins") or address_arr.include?("min") or address_arr.count == 1
      minutes = Integer(address_arr.at(0))
      hasAddress = false
    else
      if a == "123 Fake Street"
        result = 2100
      else
        url = "http://maps.googleapis.com/maps/api/directions/xml?origin=" + 
          address_arr.join('%20') + "&destination=2001%20Sheridan%20Evanston,%20IL&sensor=false&mode=walking"
        uri = URI.parse(url)
        response = Net::HTTP::Get.new(uri)
        xml = Net::HTTP.start(uri.host, uri.port) {|http|
          http.request(response).body
        }
        duration = xml.split(' mins</text>')[-2]
        if duration != nil
          duration = duration.split('<text>')[-1]
          minutes = Integer(duration)
        else
          minutes = 5
        end
        
        tmp = a.split(' ')[0..1]
        addressText = tmp[0] + " " + tmp[1].capitalize
      end
    end

    if (b == "Studio")
      bedrooms = 0.5
    else
      bedrooms = Float(b)
    end

    if p == ""
      price = 0
    else
      price = Integer(p)
    end
    
    suggestedRange = self.regression_model(bedrooms, minutes)
    if price != 0 and hasAddress
      if price > suggestedRange * 0.5 and price < suggestedRange * 1.5
        if minutes < 40
          self.create(:address => addressText, :bedrooms => bedrooms, :minutes => minutes, :price => price)
        end
      end
    end
    
    if (price != 0)
      if (price > suggestedRange * 1.1)
        worthit = 1
      elsif (price < suggestedRange * 0.9)
        worthit = 3
      else 
        worthit = 2
      end
    else
      worthit = 0
    end
    if bedrooms == 0.5
      bedroomText = "studio"
    else
      bedroomText = b + " bedroom"
    end
    explainText1 = "Price range for a " + bedroomText + " apartment" 
    explainText2 =  "about " + minutes.to_s + " minutes away:"  

    return @result = {:range => suggestedRange, :explainText1 => explainText1, 
      :explainText2 => explainText2, :worthit => worthit, :minutes => minutes}
  end
  
  def self.regression_model(b, m)
    if Regression.find(:all).empty?
      self.reset_regression
    end
    
    regression = Regression.order("created_at").last
    range = regression.constant + regression.bedroom_coefficient * b + 
      regression.minutes_coefficient * Float(1/m)
  end
  
end
