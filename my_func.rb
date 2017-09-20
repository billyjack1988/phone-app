require "pg"
load './local_env.rb' if File.exist?('./local_env.rb')

def add_numbers(arr)

db_params = {
	host: ENV['host'],
	port: ENV['port'],
	dbname: ENV['dbname'],
	user: ENV['user'],
	password: ENV['password']
}
db = PG::Connection.new(db_params)
answer = ""
check = db.exec("SELECT * FROM phonenum_table WHERE phone = '#{arr[-1]}'")

	if check.num_tuples.zero? == false
		answer = "Your Number is already being used"
	else
		answer = "you join this phone book"
		db.exec("insert into phonenum_table(first_name,last_name,address,city,state,zip,phone)VALUES('#{arr[0]}','#{arr[1]}','#{arr[2]}','#{arr[3]}','#{arr[4]}','#{arr[5]}','#{arr[6]}')")
	end
	answer
end


def database_info()
	db_params = {
	host: ENV['host'],
	port: ENV['port'],
	dbname: ENV['dbname'],
	user: ENV['user'],
	password: ENV['password']
}
data = []
db = PG::Connection.new(db_params)
 db.exec( "SELECT * FROM phonenum_table" ) do |result|
      result.each do |row|
      	data << row.values
      end
    end
   data
end

def search_data_phone(info)
	db_params = {
	host: ENV['host'],
	port: ENV['port'],
	dbname: ENV['dbname'],
	user: ENV['user'],
	password: ENV['password']
}
	db = PG::Connection.new(db_params)
	check = db.exec("SELECT * FROM phonenum_table WHERE phone = '#{info}'")
	
	if check.num_tuples.zero? == false
			search_answer = check.values
	else
		search_answer = "isnt in phone book"
	end

	end

def search_data_lname(info)
	db_params = {
	host: ENV['host'],
	port: ENV['port'],
	dbname: ENV['dbname'],
	user: ENV['user'],
	password: ENV['password']
}
db = PG::Connection.new(db_params)
check = db.exec("SELECT * FROM phonenum_table WHERE last_name = '#{info}'")
yup = check.num_tuples
if check.num_tuples.zero? == false
	search_answer = check.values
else
	search_answer = "isnt in phone book"
end
end
# get_info_database()


def update_table(info_new,old_phone)
		db_params = {
	host: ENV['host'],
	port: ENV['port'],
	dbname: ENV['dbname'],
	user: ENV['user'],
	password: ENV['password']
}
db = PG::Connection.new(db_params)
	counter = 0
	info_new.each do |arr|
		db.exec("UPDATE phonenum_table SET first_name = '#{arr[0]}' ,last_name = '#{arr[1]}',address = '#{arr[2]}',city = '#{arr[3]}',state = '#{arr[4]}',zip = '#{arr[5]}',phone = '#{arr[6]}'WHERE phone = '#{old_phone[counter]}'")
		counter =+ 1
	end	
end

def delete_from_table(delete_info)
	db_params = {
	host: ENV['host'],
	port: ENV['port'],
	dbname: ENV['dbname'],
	user: ENV['user'],
	password: ENV['password']
}
db = PG::Connection.new(db_params)
	arr = []
	delete_info.each do |row|
		yup = row.split(',')
		arr << yup
	end
	arr.each do |row|
		delete_num = row[-1]
		db.exec("DELETE FROM phonenum_table WHERE phone = '#{delete_num}'")
	end

end
