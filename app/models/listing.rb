class Listing < ActiveRecord::Base

  def self.import_data(a, p, b)
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
  
    suggestedRange = 442 + 515 * bedrooms + Float(4374 * 1/minutes)
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
  
end
