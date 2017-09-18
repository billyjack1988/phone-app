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