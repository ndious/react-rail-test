json.contract do
  json.id @contract.id
  json.number @contract.number
  json.status @contract.status
  json.client @contract.users do |user|
    json.id user.id
    json.email user.email
  end
  json.start_at @contract.start_at
  json.end_at @contract.end_at
  json.created_at @contract.created_at
  json.updated_at @contract.updated_at
end


