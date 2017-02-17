require 'sinatra'
#require 'sinatra/reloader'

def cipher (sentence, shift_value)
	shift_value = shift_value.to_i
	letters = sentence.split("")
	letter_A = 65
	letter_Z = 90

	index = 0
	letters.each do
		letters[index] = letters[index].upcase
		index+=1
	end

	index = 0

	# change each letter to int val and shift and change back to str
	letters.each do |letter| 
		letter = letter.ord
		
		if letter >= letter_A && letter <= letter_Z
			letters[index] = letter
			
			letters[index] = letters[index] - shift_value
			if letters[index] < letter_A
				val = letter_A - letters[index]
				letters[index] = letter_Z - val
			end

			letters[index] = letters[index].chr.downcase

		end

		index += 1
	end
	
	result = letters.join.capitalize
	result	
end

get '/' do
	erb :index
end

post '/result' do
	if params[:sentence] != ""
		if params[:shift_value] != "" && (params[:shift_value].to_i >= 0 && params[:shift_value].to_i <= 10)
			encrypted_sentence = cipher(params[:sentence],params[:shift_value])
			erb :result, :locals => { :sentence=>encrypted_sentence }
		else
			erb :index
		end
	else
		erb :index
	end
end
