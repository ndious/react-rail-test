json.user do
  json.id @user.id
  json.email @user.email
  json.role @user.role
  json.created_at @user.created_at
  json.updated_at @user.updated_at
  json.contracts @user.contracts do |contract|
    json.id contract.id
  end
end

