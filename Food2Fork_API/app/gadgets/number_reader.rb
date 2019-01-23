
# read string, number, fraction and monsters into float
def number_reader(number_string)
  numerator, denominator = number_string.split('/').map(&:to_f)
  denominator ||= 1
  usage = numerator/denominator
  return usage
end

#
