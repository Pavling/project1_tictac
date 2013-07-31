  User.destroy_all

c = User.create!({:first_name => 'James', :last_name =>'Elliott', :password_digest => 'admin', :username => 'admin'})

c2 = User.create!({:first_name => 'Jon', :last_name =>'Smith', :password_digest => 'admin', :username => 'admin'})

c3 = User.create!({:first_name => 'Charlie', :last_name =>'Smith', :password_digest => 'admin', :username => 'admin'})



