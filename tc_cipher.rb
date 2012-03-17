require "./cipher"
require "test/unit"

$digits = Array("0".."9")
$hex_alphabet = $digits + Array("a".."f")
$alphabet = [' '] + Array("a".."z")
 
class TestValue < Test::Unit::TestCase

  def test_first_alphabet_letter_should_have_zero_value
    assert_equal(0, value("0", $digits))
  end

  def test_second_alphabet_letter_should_have_value_one
    assert_equal(1, value("1", $digits))
  end

  def test_last_alphabet_letter_should_have_value_equal_to_alphabet_size
    assert_equal(9, value("9", $digits))
  end

  def test_leading_zero_should_have_no_value
    assert_equal(0, value("00", $digits))
    assert_equal(0, value("000", $digits))
  end

  def test_value_depends_on_position
    assert_equal(10, value("10", $digits))
    assert_equal(100, value("100", $digits))
  end

  def test_values_should_be_sum
	assert_equal(11, value("11", $digits))
    assert_equal(101, value("101", $digits))
  end

  def test_converts_binary_to_decimal
  	assert_equal(0, value("000", "01"))
  	assert_equal(1, value("001", "01"))
  	assert_equal(2, value("010", "01"))
  	assert_equal(3, value("011", "01"))
  	assert_equal(4, value("100", "01"))
  end

  def test_converts_hex_to_decimal
  	assert_equal(  0, value("00", $hex_alphabet))
  	assert_equal(  9, value("09", $hex_alphabet))
  	assert_equal( 15, value("0f", $hex_alphabet))
  	assert_equal( 16, value("10", $hex_alphabet))
  	assert_equal(255, value("ff", $hex_alphabet))
  end
end

class TestToText < Test::Unit::TestCase

  def test_should_convert_numbers_to_string
  	assert_equal("0", to_text(0, $digits))
  	assert_equal("1", to_text(1, $digits))
  	assert_equal("10", to_text(10, $digits))
  	assert_equal("1234", to_text(1234, $digits))
  end

  def test_should_convert_to_binary
  	assert_equal("0", to_text(0, "01"))
  	assert_equal("1", to_text(1, "01"))
  	assert_equal("10", to_text(2, "01"))
  	assert_equal("11", to_text(3, "01"))
  	assert_equal("100", to_text(4, "01"))
  end

  def test_should_convert_to_hex
  	assert_equal( "0", to_text(  0, $hex_alphabet))
  	assert_equal( "9", to_text(  9, $hex_alphabet))
  	assert_equal( "f", to_text( 15, $hex_alphabet))
  	assert_equal("10", to_text( 16, $hex_alphabet))
  	assert_equal("ff", to_text(255, $hex_alphabet))
  end
end

class TestTranslate < Test::Unit::TestCase

	def test_should_convert_binary_to_hex
		assert_equal("0", translate("0", "01", $hex_alphabet))
		assert_equal("ff", translate("11111111", "01", $hex_alphabet))
	end

	def test_should_convert_hex_to_binary
		assert_equal("0", translate("0", $hex_alphabet, "01"))
		assert_equal("11111111", translate("ff", $hex_alphabet, "01"))
	end

	def test_translation_is_reversible
		raw = "juarez bochi"
		laugh_alphabet = "Hhaeou"
		ciphered = translate(raw, $alphabet, laugh_alphabet)
    assert_equal("", ciphered)
		assert_equal(raw, translate(ciphered, laugh_alphabet, $alphabet))
	end

	def test_can_do_caesar_cipher		
		letters = Array('a'..'z')
		rot13 = letters.rotate(13)
		assert_equal("uryyb", translate("hello", letters, rot13))
		assert_equal("hello", translate("uryyb", letters, rot13))
	end

	def test_can_do_atbash_cipher
		letters = Array('a'..'z')
		atbash = letters.reverse
		assert_equal("hob", translate("sly", letters, atbash))
		assert_equal("hold", translate("slow", letters, atbash))
	end
end
