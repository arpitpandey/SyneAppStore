class AdminController < ApplicationController
	def addproduct
		@product = Product.new
	end	
	
	def addrecord
		@product = Product.new(params[:product])
      if @product.save
			@product = Product.all
			render :action => 'index'
		else
			render :action => 'failure'
		end
	end
	
	def index
		@product = Product.all
		respond_to do |format|
		  format.html # home.html.erb
		  format.json { render json: @product }
		end
	end
	
	def active
		product = Product.find(params[:id])
				if product.isactive?
				else
					product.isactive=true
				end	
		product.save
		@product = Product.all
		render :action => 'index'
	end
	
	def delete
		product = Product.find(params[:id])
			product.destroy
			@product = Product.all
		render :action => 'index'
	end
	
	def deactive
		product = Product.find(params[:id])
			if product.isactive?
			 product.isactive=false
			end
		product.save
		@product = Product.all
		render :action => 'index'
	end
end
