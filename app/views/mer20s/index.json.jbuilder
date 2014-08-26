json.array!(@mer20s) do |mer20|
  json.extract! mer20, :id, :sequence, :leading, :lagging, :genome_id
  json.url mer20_url(mer20, format: :json)
end
