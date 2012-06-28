class ProductsController < ApplicationController
	
	def home
	end
	
	def index

		reset_session
		$sum=0
		@product = Product.all
		@cartinfo=Cart.where(:sessionId => session[:session_id]).all
   end 
   
   def accesoriapp
		@product = Product.where(:ptype => 'Accesories').all
		@cartinfo=Cart.where(:sessionId => session[:session_id]).all
		respond_to do |format|
		  format.html { render action: "index" }
		end
   end
   
   def toolpp
		@product = Product.where(:ptype => 'Tools').all
		@cartinfo=Cart.where(:sessionId => session[:session_id]).all
		respond_to do |format|
		  format.html { render action: "index" }
		end
   end
   
   def winapp
		@product = Product.where(:ptype => 'WindowsApp').all
		@cartinfo=Cart.where(:sessionId => session[:session_id]).all
		respond_to do |format|
		  format.html { render action: "index" }
		end
   end
   def phoneapp
		@product = Product.where(:ptype => 'PhoneApp').all
		@cartinfo=Cart.where(:sessionId => session[:session_id]).all
		respond_to do |format|
		  format.html { render action: "index" }
		end
   end
   
   def addcart
		@pid=(params[:id])
		@p_price=Product.find(@pid)
		@price=0
			@temp_cart=Cart.find(:first, :conditions => { :sessionId => session[:session_id], :productId => @pid }) 
			if @temp_cart
				@temp_cart.update_attributes(:quantity => (@temp_cart.quantity != 0) ?  @temp_cart.quantity += 1 : 1)
				@price= @temp_cart.productPrice+@p_price.price
				@temp_cart.update_attributes(:productPrice =>@price)
			else
				product = Product.find(params[:id])
				@cart = Cart.create(:sessionId =>  session[:session_id], :quantity =>  1, :productId => @pid, :productName => product.name, :productPrice => product.price)
				@cart.save
			end
			
		@product = Product.all
		@cartinfo=Cart.where(:sessionId => session[:session_id]).all
		
		for cart in @cartinfo
			$sum += cart.productPrice
		end
		respond_to do |format|
		  format.html { render action: "index" }
		end
   end
   
   
   def cartdelete
		cartinfo=Cart.find(params[:id])
		$sum -= cartinfo.productPrice
		cartinfo.destroy
		@cartinfo=Cart.where(:sessionId => session[:session_id]).all
		@product = Product.all
		respond_to do |format|
		  format.html { render action: "index" }
		end
   end 
   
   def makepayment
   $amount = $sum
   $amount = $amount*54
    ActiveMerchant::Billing::Base.mode = :test
    setup_response = gateway.setup_purchase($amount,
		:ip                => request.remote_ip,
		:return_url        => url_for(:action => 'confirm', :only_path => false),
		:cancel_return_url => url_for(:action => 'index', :only_path => false)
		)
		redirect_to gateway.redirect_url_for(setup_response.token)
  end

  def confirm
    redirect_to :action => 'failure' unless params[:token]
    details_response = gateway.details_for(params[:token])
    if !details_response.success?
      @message = details_response.message
      render :action => 'invalid'
      return
    end

    @address = details_response.address
  end

  def complete
 
    purchase = gateway.purchase($amount,
      :ip       => request.remote_ip,
      :payer_id => params[:payer_id],
      :token    => params[:token]
    )
    if !purchase.success?
      @message = purchase.message
      render :action => 'invalid'
      return
    else
      render :action => 'success'
    end
  end


  def gateway
  @gateway ||= ActiveMerchant::Billing::PaypalExpressGateway.new(
    :login    => "sencha_1337868048_biz_api1.yahoo.com",
			:password => "1337868090",
			:signature => "Aejy.wTjg4ea0KV.hYXfwe0krup6AhbEBAGV.wtS-5HDqDLZFxj.dsyp "
  )
  end
   
end
