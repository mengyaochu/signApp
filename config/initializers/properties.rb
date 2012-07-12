class Properties
     @people_size_min = []
      20.times do |i|
         @people_size_min.push(i+1)
      end

     @people_size_max = []
     100.times do |i|
       @people_size_max.push(i+1)
     end

     @seats_size_per_day = []
     100.times do |i|
       @seats_size_per_day.push(i+20)
     end

     ::SEATS_SIZE_PER_DAY = @seats_size_per_day

     ::PEOPLE_SIZE_MIN = @people_size_min

     ::PEOPLE_SIZE_MAX = @people_size_max

     ::CUISINE_TYPE = ['Chinese', 'Continental', 'Italian', 'Japanese', 'Mexican', 'Mughlai', 'Multi cuisine', 'North Indian', 'South Indian', 'Thai']

     ::TYPE_OF_OFFER_BAN = ['Offer valid all days', 'Offer valid only week ends (sat and sun)]', 'Offer valid only week days (monday to friday)' ]

     ::TYPE_OF_OFFER = ['Offer valid all days', 'Offer valid only week ends (sat and sun)]', 'Offer valid only week days (monday to friday)', 'Offer valid only specific days', 'Everyday different offer' ]

     ::TYPE_OF_OFFER_DEL = ['Offer valid all days', 'Offer valid only week ends (sat and sun)]', 'Offer valid only week days (monday to friday)', 'Offer valid only specific days' ]

     ::DISCOUNT = ['0%', '10%', '15%', '20%', '25%', '30%', '35%', '40%', '45%', '50%', '55%', '60%', '65%', '70%', '75%', '80%', '85%', '90%']

     ::LUNCH_TIME = ['12PM to 2PM', '12PM to 3PM', '12PM to 4PM', '1PM to 2PM', '1PM to 3PM', '1PM to 4PM', '2PM to 3PM', '2PM to 4PM']

     ::DINNER_TIME = ['7PM to 9PM', '7PM to 10PM', '7AM to 11PM', '8PM to 10PM', '8PM to 11PM', '9PM to 10PM', '9PM to 11PM', '10PM to 11PM']

     ::DAYS = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']

     ::ITEM_TYPE = ['Chicken','Mutton','Seafood','Bread - Naan & Roti' ,'Rice', 'Kebab - Roll' ,'Soup','Noodles','Port','Dessert','Beef','Drink', 'Ice-cream']


    @people_size_min_ban = []
      51.times do |i|
         @people_size_min_ban.push(i+50)
      end

     @people_size_max_ban = []
     500.times do |i|
       @people_size_max_ban.push(i+51)
     end

   ::PEOPLE_SIZE_MIN_BAN = @people_size_min_ban

   ::PEOPLE_SIZE_MAX_BAN = @people_size_max_ban
end