def value(text, alphabet)
	value = 0
	exp = text.length - 1
	base = alphabet.length

	for char in text.chars do
		value += ((alphabet.index(char)) * (base ** exp))
		exp -= 1
	end
	value
end

def to_text(value, alphabet)
	text = ""
	base = alphabet.length
	while true
		text = text.prepend(alphabet[value % base])
		value = value / base
		if value == 0
			return text
		end
	end
end

def translate(text, input_alphabet, output_alphabet)
	return to_text(value(text, input_alphabet), output_alphabet)
end