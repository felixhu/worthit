json.array!(@regressions) do |regression|
  json.extract! regression, :constant, :bedroom_coefficient, :minutes_coefficient
  json.url regression_url(regression, format: :json)
end