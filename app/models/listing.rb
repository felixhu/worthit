require 'statsample'
require 'csv'
require 'net/http'

class Listing < ActiveRecord::Base
  
  def self.calculate_regression
    l = Listing.find(:all)
    b = Array.new(l.count).to_scale
    m = Array.new(l.count).to_scale
    l.each_with_index do |listing, index|
      b[index] = listing.bedrooms
      m[index] = listing.minutes
    end
    ds = {'bedrooms' => b, 'minutes' => m}.to_dataset
    ds['price'] = ds.collect{|row| 442 + 515 * row['bedrooms'] + 4371 * 1 / row['minutes']}
    lr=Statsample::Regression.multiple(ds,'price')
    puts lr.summary
    result = String(lr.summary)
    
    constant = result.split('| Constant | ')[1]
    constant = Sconstant.split(' | ')[0]
    bedroomCoef = result.split('| bedrooms | ')[1]
    bedroomCoef = bedroomCoef.split(' | ')[0]
    minCoef = result.split('minutes ')[-1]
    minCoef = minCoef.split(' | ')[1]
  end
  
  def self.import_data(csv)
    CSV.parse(csv) do |row|
      address_arr = row[0].split(' ')[0...2]
      address = String(address_arr.at(0)) + " " + String(address_arr.at(1))
      bedrooms = Float(row[1])
      minutes = Integer(row[2])
      estimatedPrice = self.regression_model(bedrooms, minutes)
      price = Integer(row[3])
      
      if minutes > 0 and minutes < 30 and price > 0.6 * estimatedPrice and price < 1.4 * estimatedPrice
        Listing.create(:address => address, :price => price, :bedrooms => bedrooms, :minutes => minutes)
      end
    end
  end
  
  def self.new_data(a, p, b)
    address = a.split(' ')
    if address.include?("minutes") or address.include?("mins") or address.count == 1
      minutes = Integer(address.at(0))
      address = nil
    else
      if a == "123 Fake Street"
        result = 2100
      else
        url = "http://maps.googleapis.com/maps/api/directions/xml?origin=" + address.join('%20') + "&destination=2001%20Sheridan%20Evanston,%20IL&sensor=false&mode=walking"
        uri = URI.parse(url)
        response = Net::HTTP::Get.new(uri)
        xml = Net::HTTP.start(uri.host, uri.port) {|http|
          http.request(response).body
        }
  
        #XML does not parse properly when the address is too close, to fix we'll change
        #the method to reg exp, to avoid crashes
        duration = xml.split(' mins</text>')[-2]
        duration = duration.split('<text>')[-1]
        minutes = Integer(duration)
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
  
    if price != 0 and address
      if price > 500 and price < 5000
        if minutes < 30
          self.create(:address => a, :bedrooms => bedrooms, :minutes => minutes, :price => price)
        end
      end
    end
  
    suggestedRange = self.regression_model(bedrooms, minutes)
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
    range = 442 + 515 * b + Float(4374 * 1/m)
  end
  
end
