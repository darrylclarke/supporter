class SupportRequestsController < ApplicationController
	# def initialize
	# 	super
	# 	@@search_for ||= ""
		
	# end 
	
	before_action :find_support_request, only: [:show, :edit, :update, :destroy, :done]
	
	def index
		print ">>>> index with " + SupportRequest::get_search_string + "\n"
		if SupportRequest::get_search_string && SupportRequest::get_search_string != ""
			@support_requests = SupportRequest.all.search(SupportRequest::get_search_string).order(:done)
		else
			@support_requests = SupportRequest.all.order(:done)
		end
	end
	
	def new
		@support_request = SupportRequest.new
	end
	
	def create
		@support_request = SupportRequest.new( support_request_params )
		@support_request.done = false
		if @support_request.save
			redirect_to support_request_path( @support_request ), notice:  'Support Request Created.'
		else
			flash[ :alert ] = 'See errors below...'
			render :new
		end
	end
	
	def show
	end
	
	def edit
	end
	
	def update
		# print "***** Department is " + params[:department] + "\n"
		
		if @support_request.update support_request_params
			redirect_to support_request_path( @support_request )
		else
			render :edit
		end
	end
	
	def destroy
		@support_request.destroy
		redirect_to support_requests_path
	end
	
	def done
		newval = !@support_request.done
		@support_request.update_attribute(:done, newval)
		redirect_to support_requests_path
	end
	
	def search
		SupportRequest::set_search_string params[:search_for]
		print "Searching for:  " + SupportRequest::get_search_string, "\n"
		redirect_to support_requests_path
	end
	
private

	def find_support_request
		@support_request = SupportRequest.find params[:id]
	end
	
	def support_request_params
		# print "************ ", params, "***** **\n"
        x = params.require( :support_request ).permit( :name, :email, :message, :done, :department )
		# print "((((((((((( " + params[:support_request][:done] + "/n"
		# x[:done] = params[:support_request][:done] == "1" ? true : false
		# print "(((((((((() " + x[:done].to_s + "/n"
		x[:department] = params[:department]
		# print "************ ", x, "***** **\n"
		x
	end
end

