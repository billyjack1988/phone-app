require 'sinatra'
require 'pg'
require_relative 'my_func.rb'
enable :sessions
load './local_env.rb' if File.exist?('./local_env.rb')

get '/' do
    erb :info_page
end

post '/results' do
info = params[:info]
answer = add_numbers(info)
redirect '/resultspage?answer=' + answer
end

get '/resultspage' do
	answer = params[:answer]
	phone_book = database_info()
	erb :results, locals:{answer:answer,phone_book:phone_book}
end

post "/search" do
	lname = params[:lname]
	phone = params[:phone]
	
	if phone == "" and lname == ""
		session[:search_answer] = "Need search term"
	elsif phone == ""
		session[:search_answer] = search_data_lname(lname)
	else
		session[:search_answer] = search_data_phone(phone)
	end
	redirect "/search_answer?"
end

get "/search_answer" do

erb :seachandupdate, locals:{search_answer:session[:search_answer]}
end

post "/update" do
	session[:info] = params[:info]
	choose = params[:choose]
	if session[:info] == nil
		answer = "Didn't Change"
		redirect "/answer_page?answer=" + answer
	else
		if choose == "update"
			redirect "/update_answer?"
		else
			redirect "/delete?"
		end
	end

end

get "/update_answer" do
erb :update, locals:{info:session[:info]}
end

post '/updated' do
	answer = "Info Updated"
  updated_info = params[:info]
	updated_slice = updated_info.each_slice(7).to_a
  info = session[:info]
  old_phone = []
  
  info.each do |row|
  	split = row.split(',')
  	old_phone << split[-1]
  end
   update_table(updated_slice,old_phone)
   redirect "/resultspage?answer=" + answer
end

get "/delete" do
	answer = "Info DELETED"
	deleting_info = session[:info]
	delete_from_table(deleting_info)
	redirect "/resultspage?answer=" + answer
end