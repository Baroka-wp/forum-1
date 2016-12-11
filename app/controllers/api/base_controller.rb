class Api::BaseController < ApplicationController
	
	before_action :authorize_header_token
	skip_before_action :verify_authenticity_token
	#before_action :enable_cors
	before_action :set_default_format
	rescue_from Exception, with: :respond_500
	rescue_from ActionController::RoutingError, with: :respond_404


	private

	def authorize_header_token
	    respond_error unless request.headers.to_h["HTTP_X_TOKEN"] == "123456"
	end

	def enable_cors
		headers['Access-Control-Allow-Origin'] = '*' 
		headers['Access-Control-Allow-Methods'] = 'GET, POST, PUT, DELETE'
		headers['Access-Control-Allow-Headers'] = 'Origin, X-Atmosphere-tracking-id, X-Atmosphere-Framework, X-Cache-Date, Content-Type, X-Atmosphere-Transport, X-Remote, api_key, auth_token, *'
		headers['Access-Control-Request-Method'] = 'GET, POST, PUT, DELETE'
		headers['Access-Control-Request-Headers'] = 'Origin, X-Atmosphere-tracking-id, X-Atmosphere-Framework, X-Cache-Date, Content-Type, X-Atmosphere-Transport,  X-Remote, api_key, *'
		# Access-Control-Allow-Headers Access-Control-Request-Method 是一樣的只是瀏覽器的預設名稱不一樣 
	end

	def set_default_format
		request.format = 'json'
	end	

	def respond_error(message, status = nil)
		status ||= 400
		render json: { message: message } , status: status
	end

	def respond_200(hash_data)
		response.headers['Accept-Language'] = 'zh_TW'
		render json: hash_data
	end

	def respond_400(exception)
		respond_error(exceotion.message , 400)
	end

	def page_404
	    fail  ActionController::RoutingError.new("No route matches /#{params[:unmatched_route]}")
	end

	def respond_500(exception)
		responde_error(exception.message , 500)
	end

end

