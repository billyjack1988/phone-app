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






