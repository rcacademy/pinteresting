json.array!(@pins) do |pin|
  json.extract! pin, :id, :description
  json.url pin_url(pin, format: :json)
end
