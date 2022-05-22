json.array! @contracts do |contract|
  json.id contract.id
  json.number contract.number
  json.status contract.status
  json.start_at contract.start_at
  json.end_at contract.end_at
end


