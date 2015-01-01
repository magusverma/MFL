json.array!(@bills) do |bill|
  json.extract! bill, :id, :club, :cart, :type, :email, :sms, :html
  json.url bill_url(bill, format: :json)
end
