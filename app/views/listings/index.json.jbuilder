json.array!(@listings) do |listing|
  json.extract! listing, :address, :bedrooms, :minutes, :price
  json.url listing_url(listing, format: :json)
end