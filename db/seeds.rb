user = User.create! :email => 'sencha12@mail.com', :password => 'ramesh', :password_confirmation => 'ramesh'
p user
user2 = User.create! :email => 'neev12@mail.com', :password => 'neeraj', :password_confirmation => 'neeraj'
p user2
user.add_role :admin