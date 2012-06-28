TrailProject::Application.routes.draw do

  devise_for :users do
	root :to => 'products#home'
	get 'logout' => 'devise/sessions#destroy'

	match "addproduct" => "admin#addproduct", as: :addproduct
	match "productlist" => "admin#index", as: :productindex
	match "active/:id" => "admin#active", as: :active
	match "deactive/:id" => "admin#deactive", as: :deactive
	match "delete/:id" => "admin#delete", as: :delete
	match "create" => "admin#addrecord"
  end
	root :to => 'products#home'
	match "home" => "products#home", as: :home 
	match "phoneapp" => "products#phoneapp", as: :phoneapp
	match "toolpp" => "products#toolpp", as: :toolpp
	match "winapp" => "products#winapp", as: :winapp
	
	match "accesoriapp" => "products#accesoriapp", as: :accesoriapp
	
	match "addcart/:id" => "products#addcart", as: :addcart
	match "cartdelete/:id" => "products#cartdelete", as: :cartdelete
	match "makepayment" => "products#makepayment", as: :makepayment
	match "complete" => "products#complete", as: :complete
	match "confirm" => "products#confirm", as: :confirm
	match "index" => "products#index", as: :index

end
