require 'rubygems'
require 'sinatra'
require 'pony'

set :public_folder, 'settings'

get '/' do
  	@title = 'cHealth | Bringing Simplicity to Healthcare'
   	erb :home
end

get '/about-us' do
  	@title = 'About us | Bringing Simplicity to Healthcare'
   	erb :about
end

get '/why-chealth' do
  	@title = 'Why cHealth | Bringing Simplicity to Healthcare'
   	erb :why_chealth
end

get '/case-study' do
  	@title = 'Case Study | Bringing Simplicity to Healthcare'
   	erb :case_study
end

get '/contact-us' do
	@title = 'Contact Us | Bringing Simplicity to Healthcare'
	erb :contact_us
end

get '/email-success' do
	@title = 'Your email was successfully sent | Bringing Simplicity to Healthcare'
	erb :email_success
end

get '/email-fail' do
	@title = 'Sorry, your email was not sent. Kindly resend again. | Bringing Simplicity to Healthcare'
	erb :email_fail
end


post '/contact-us' do 
  	Pony.options = {
	    :via => :smtp,
	    :via_options => {
	        :address              => 'in-v3.mailjet.com',
	        :port                 => '25',
	        :user_name            => '6a51c1db27dccb06ea78ecce566c709c',
		   	:password             => 'd62dd7850329ddbe5624999c33cdf1fd',
	        :authentication       => :plain, 
	        :domain               => 'chealth.io' 
		}  
  	}
  		firstName 	= params[:firstName]
		lastName  	= params[:lastName]
		fullName  	= "#{firstName}" + " #{lastName}"
  		senderEmail = params[:replyTo]
  		userPhone 	= params[:userPhone]
  		message 	= params[:message]
  		logger.error params.inspect
  	begin
  		Pony.mail :from=>"cHealth.io <info@chealth.io>", :to=>"info@chealth.io", :subject=>"#{fullName} message via www.chealth.io", :body=>"#{fullName} with email address: #{senderEmail} sent a message via www.chealth.io: ' #{message}'"
    	redirect '/email-success'
	rescue
	    @except = $!
	    redirect '/email-fail'
  	end
end


not_found do
  erb :page_not_found
end