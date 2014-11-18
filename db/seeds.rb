Applingo.delete_all
Appcolors.delete_all

Applingo.create(
	[
		{line: 'Foodlane - The Best Online Food Ordering Website'	,context: 'meta-description' 			,page: '/'},
		{line: 'Foodlane'											,context: 'meta-author' 				,page: '/'},
		{line: 'Dashboard, Foodlane, Food, Online, Ordering, India'	,context: 'meta-search-tags' 			,page: '/'},
		{line: 'Foodlane - The Best Online Food Ordering Website'	,context: 'dashboard-titlebar-heading'  ,page: '/'},
		{line: 'Foodlane'											,context: 'logo' 						,page: '/'},
		{line: 'Foodlane'											,context: 'homepage-heading' 			,page: '/'},
		{line: 'because we just love ordering food' 				,context: 'homepage-heading-tagline' 	,page: '/'},
		{line: 'Login with Facebook' 								,context: 'homepage-login-button' 		,page: '/'},
		{line: 'Foodlane is where you can collaborate easily with people around you for ordering food online with less bill' 	,context: 'homepage-description' ,page: '/'},	
		{line: 'know more'			 								,context: 'homepage-descriptioncontinue',page: '/'},				
		{line: 'My pending foodlanes'								,context: 'navbar-collaborate-status'	,page: '/dashboard'},				
		{line: 'What\'s Up'											,context: 'dashboard-right-sidebar-head',page: '/dashboard'}				
	]
)

Appcolors.create(
	[
		{value: 0			,tag:"topbar" 				,context:"dashboard" 	,page:"/*"},
		{value: 0			,tag:"right-sidebar" 		,context:"dashboard" 	,page:"/dash"}			
	]
) 

j = JSON.parse('{"name":"Magus Verma","provider":"google_oauth2","uid":"107827319509519119529","role":"admin","image":"https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg?sz=50","phone":null,"address":null,"email":"Magus12141@iiitd.ac.n","first_name":"Magus","last_name":"Verma"}')
User.create(j)
u = User.where(:email => "Magus12141@iiitd.ac.ina").take

if u.nil?
	uid = 1
else
	uid = u.id
end

Items = [
	["Mexican Pizza",300,1,1,""],
	["Italian Pizza",400,1,1,""],
	["Cheese Burst Pizza",500,1,1,""],

	["Masala Dosa",100,2,2,""],
	["Rava Dosa",120,2,2,""],
	["Uttapam",100,3,2,""]
]

Categories = [
	"Pizza",
	"Dosa",
	"Uttapam"
]

Restaurants = [
	["Chicago Pizza","Nehru Place","Chicago Pizza - India's fastest growing fast food service restaurant for casual and fine dining",400,"/assets/img/chicago.jpeg"],
	["Sagar Ratna","Okhla","a time immemorial South Indian Restaurant Chain; in fact it is open in most areas of Delhi-NCR and is quite recognised by most people.",500,"http://www.theoceanpearl.in/images/SagarRatna_logo.jpg"]
]

Carts = [
	[1,1,1,100,10,"Boys Hostel,IIIT Delhi"],
	[1,1,2,200,20,"Girls Hostel,IIIT Delhi"],
	[2,nil,1,50,5,"Academic Building,IIIT Delhi"]	
]

Items.each do |name,price,category_id,restaurant_id,url|
	i = Item
	Item.create( name: name, price: price, category_id: category_id,restaurant_id: restaurant_id, photo_url: url)
end

Categories.each do |name|
	Category.create(name: name)
end

Restaurants.each do |name,location,about,min_bill,photo_url|
	Restaurant.create(name: name,location: location,about: about,min_bill: min_bill,photo_url: photo_url)
end

# Remove Restaurant Name
# Remove Taxess
Carts.each do |restaurant_id,club_id,user_id,bill_amount,vat,address|
	Cart.create(restaurant_id: restaurant_id,club_id: club_id,user_id: user_id,bill_amount: bill_amount,vat: vat,address: address)
end

# Drop price,item_name
CartItems = [
	[1,1,3], # First Pizza Collaborating Cart
	[2,2,2], # Second Pizza Colloborating Cart
	[3,4,5]
]

# Add Quantity
CartItems.each do |cart_id,item_id,quantity|
	Cartitem.create(cart_id: cart_id,item_id: item_id,quantity: quantity);
end

#Club Request Messages
#Club Request Accepted
#drop clubid,name,description
if Club.first.nil? 
	c = Club.new
	c1 = Cart.first
	c2 = Cart.first(2).last

	c.user_id = 1 #c1.user
	c.master_cart_id = c1.id
	c1.club = c
	c1.club_status = :confirm
	c1.save

	c2.club = c
	c2.club_status = :pending
	c2.save

	c.save
end

#Club.first.carts.first.cartitems.first.item
if Clubchat.first.nil? 
	cc = Clubchat.new 
	cc.club = Club.first
	cc.user_id = 1 #User.first(2).last
	cc.cart = Club.first.carts.last
	cc.message = "Hey dude lets club orders! here's my cart"
	cc.save
end

# User.create(name: "Magus Verma",about: "Student at IIITD", email: "magus@gmail.com")

puts "Database now has "+User.all.count.to_s+ " users, "+Item.all.count.to_s + " items, "+Category.all.count.to_s + " categories, "+Restaurant.all.count.to_s + " Restaurant, "+Cart.all.count.to_s + " Cart, "+Cartitem.all.count.to_s + " Cartitems, "+Club.all.count.to_s + " Clubs, "+Clubchat.all.count.to_s + " Clubchats, "
