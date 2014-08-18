json.array!(@mer20s) do |mer20|
  json.extract! mer20, :id, :sequence, :strand
  json.url mer20_url(mer20, format: :json)
end
