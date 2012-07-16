require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'sqlite3'
require 'mysql'

# Variables...

total_page = 15	# limit number for browsable pages
item_count = 0		# total count of items

term = "FALL 2012"
termId = "201203"

base_url = "http://my.gwu.edu/mod/pws/courses.cfm?campId=1&termId=#{termId}"

# mysql config, you can change this configuration according to your environment.
db_type =  "mysql"

host = "127.0.0.1"
user = "root"
passwd = ""
dbname = "project_development"
tblname = "courses"


############################################
# parse the html content from table row
############################################
def parse_html_with_row(rows, index, category)
	return_array = {}		# return array
	tmp_item = {}
	
	flag = 1
	
	items = rows.collect do |row|
		if flag == 3 then
			tmp_fee = row.at_xpath('td[1]/table/tr/td[2]/text()').to_s.strip.gsub(/&nbsp;/,'')
			
			tmp_item['fee'] = tmp_fee
			
			return_array[index] = tmp_item
			index = index + 1
			flag = 1
			
			if (tmp_fee != '') then
				next
			end
		end 
		
		if flag == 1 then
			  item = {}
			  
			  [
			    ['status', 	'td[1]/text()'],
			    ['crn', 	'td[2]/text()'],
			    ['subject', 'td[3]/text()'],
			    ['sect', 	'td[4]/text()'],
			    ['course', 	'td[5]/text()'],
			    ['credit', 	'td[6]/text()'],
			    ['instructor', 	'td[7]/text()'],
			    ['bldg', 	'td[8]/text()'],
			    ['day', 	'td[9]/text()'],
			    ['from_to',	'td[10]/text()'],
			   ].each do |name, xpath|
			   	   case (name)
			   	   		when "subject" then
			   	    		item[name] = row.at_xpath(xpath).to_s.strip + row.at_xpath('td[3]/a/text()').to_s.strip
			 					when "bldg" then
		 			   			item[name] = row.at_xpath('td[8]/a/text()').to_s.strip + row.at_xpath(xpath).to_s.strip
		 			   		when "day" then
									day_flag = 0
									item[name] = item['time'] = ''
									row.xpath(xpath).each do |link|
										if day_flag == 0 then
											item[name] = link.content.to_s.strip
											day_flag = 1
										else
											item['time'] = link.content.to_s.strip
										end
		 			   			end
		 			   		else
			       			item[name] = row.at_xpath(xpath).to_s.strip
			       end
			       
			       item[name] = item[name].gsub(/\'/, '"')
			   end
			   
			   tmp_item = item
			   flag = 2
      	elsif flag == 2 then
			 tmp_item['comment'] = row.xpath('td[1]/text()').to_s.strip.gsub(/(?:\\[rnt])+|&nbsp;/,'').gsub(/\'/, '"')
		  	 tmp_item['department'] = category
		  	 flag = 3
		end
	end

	return return_array, index
end

################################################
# subject array to fetch the url
################################################
subject_ids = {
	'APSC'=> 'APPLIED SCIENCE ',
}


########################################################
# scrap the data
########################################################
items = {}

subject_ids.each do |key, name|
	for pagenum in 1..total_page 
		# genenrate the url to scrap the data
   		get_url = base_url + '&subjId=' + key + '&pageNum=' + pagenum.to_s()
   		
   		# get html page
   		doc = Nokogiri::HTML(open(get_url))
   		
   		# if it's empty page, you can pass this Subject scrap
   		
   		# analyze html page and put the data into the hash
   		rows_1 = doc.xpath('//tr[@class="tableRow1Font"]')
   		
   		# check if this page is empty page.
   		if (rows_1.to_s == "") then
   			printf "it's empty page, category=%s, pagenum=%i\n", key, pagenum
   			break
   		else
   			printf "get html with category=%s, pagenum=%i\n", key, pagenum
   		end
   		
   		# get data from the parsed html page
		tmp_items, item_count = parse_html_with_row(rows_1, item_count, key)
		items = items.merge(tmp_items);
		
		rows_2 = doc.xpath('//tr[@class="tableRow2Font"]')
		tmp_items, item_count = parse_html_with_row(rows_2, item_count, key)
		
		items = items.merge(tmp_items);
	end
end

puts "\ntotal count = #{items.count}"

########################################################
# insert the data to mysql table
########################################################
#logfile = File.open("query.txt", "w")
def get_regular_time(atime)
	ahour = atime[0,2].to_i
	amin = atime[3,2]
	
	if (atime[-2,2] == "PM") and (atime[0,2] != "12") then
		ahour = ahour + 12
	end
	
	t = Time.new(1999, 01, 01, ahour, amin)
	return now = t.strftime("%H:%M:%S")
end

if db_type ==  "mysql" then
	db_connector = Mysql.new(host, user, passwd)
	db_connector.select_db(dbname)
else
	db_connector = SQLite3::Database.new "../db/development.sqlite3"
end

# Initialize the table

=begin
db_connector.execute("DROP TABLE IF EXISTS #{tblname}")

query = "CREATE TABLE  #{tblname} "
query = query + " (`id` INT PRIMARY KEY, `term` VARCHAR(32), `department` VARCHAR(64), `crn` INT, `status` VARCHAR(16), `subject` VARCHAR(32), `sect` VARCHAR(16), `course` VARCHAR(128), `credit` VARCHAR(16), `instructor` VARCHAR(32), `day` VARCHAR(16), `start_time` TIME, `end_time` TIME, `from` DATE, `to` DATE, `fee` VARCHAR(32));"

logfile.puts  query

db_connector.execute(query)
=end

if db_type != "mysql" then
	db_connector.execute("DELETE FROM #{tblname}");
end

items.each do |idle_id, item|
	# split from/to date
	from = to = start_time = end_time = ''
	if (item['from_to'] != '') then
		result = item['from_to'].split(' - ')
		from = result[0]
		to = result[1]
		result = from.split('/')
		from = "20" + result[2] + "-" + result [0] + "-" + result[1]
		result = to.split('/')
		to = "20" + result[2] + "-" + result [0] + "-" + result[1]
	end
	
	if (item['time'] != '') then
		result = item['time'].split(' - ')
		start_time = get_regular_time(result[0])
		end_time = get_regular_time(result[1])
	end
	
	
	
	t = Time.now
	now = t.strftime("%y-%m-%d %H:%M:%S")
	
	day_full = ""

	for i in (0..item['day'].length - 1)
		case (item['day'][i])
		when 'M' then
			day_full = "#{day_full}, Mon"
		when 'T' then
			day_full = "#{day_full}, Tue"
		when 'W' then
			day_full = "#{day_full}, Wed"
		when 'R' then
			day_full = "#{day_full}, Thu"
		when 'F' then
			day_full = "#{day_full}, Fri"
		end
	end

	day_full = day_full[2..-1]
	
	#generate query
	query = "INSERT INTO " + tblname + " (`term`, `department`, `crn`, `status`, `subject`, `sect`, `title`, `credit`, `instructor`, `bldg`, `day`, `start_time`, `end_time`, `from`, `to`, `fee`) VALUES "
	query = query + "('" + term
	query = query + "','" + item['department']
	query = query + "', " + item['crn'] 
	query = query + ", '" + item['status'] 
	query = query + "', '" + item['subject']
	query = query + "', '" + item['sect']
	query = query + "', '" + item['course']
	query = query + "', '" + item['credit']
	query = query + "', '" + item['instructor']
	query = query + "', '" + item['bldg']
	query = query + "', '" + day_full
	query = query + "', '" + start_time
	query = query + "', '" + end_time
	query = query + "', '" + from
	query = query + "', '" + to
	query = query + "', '" + item['fee'] + "')"
	
	#logfile.puts  query
	
	#run query
	if db_type != "mysql" then
		db_connector.execute(query);
	else
		db_connector.query(query);
	end
end

db_connector.close
#logfile.close

puts "\nThanks for using this script! :)"
