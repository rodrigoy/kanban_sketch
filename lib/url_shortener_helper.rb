class URLShortenerHelper
  def self.to_url_key(kanban_id)
    Base62.to_s(kanban_id)
  end

  def self.to_kanban_id(url_key)
    Base62.to_i(url_key)
  end
end

#Class Base62 - Credits - Andrew Pilsch
#http://blog.pilsch.com/past/2009/6/7/shorten_your_own_damn_urls/
class Base62
	@@ranges = [
		('0'..'9'),
		('A'..'Z')
		]
	@@base = nil
	@@offsets = nil
	
	def self.to_s(number)
		if @@base.nil?
			@@base = self.calculate_base
		end
		string = ""
		while number > (@@base - 1)
			place = number % @@base
			string = self.lookup(place) + string
			number = number / @@base	
		end
		
		self.lookup(number) + string
	end
	
	def self.to_i(string)
		if @@base.nil?
			@@base = self.calculate_base
		end
		number = 0
		i = string.length - 1
		string.each_byte do |c|
			c = c.chr
			@@ranges.each_index do |j|
				range = @@ranges[j]
				if range.member? c
					number += (c[0] - range.to_a.first[0] + @@offsets[j]) * (@@base ** i)
					break
				end
			end
			i -= 1
		end
		number
	end
	
	def self.lookup(place)
		string = ""
		if @@base.nil?
			@@base = self.calculate_base
		end
		(0..(@@ranges.length-1)).each do |i|
			range_array = @@ranges[i].to_a
			start = 0 + @@offsets[i]
			stop = range_array.length - 1 + @@offsets[i]
			if (start..stop).member? place
				string = range_array[place - @@offsets[i]]
				break
			end 
		end
		string
	end
	
	def self.next_integer(integer)
		integer + 1
	end
	
	def self.calculate_base
		i = 0
		@@offsets = []
		@@ranges.each do |range|
			@@offsets << i
			i += range.to_a.length
		end
		i
	end
end
