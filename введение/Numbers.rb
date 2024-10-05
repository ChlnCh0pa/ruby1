# Метод для нахождения суммы простых делителей числа
def sum_of_prime_divisors(n)
  sum = 0
  for i in 2..n
    if n % i == 0 && prime?(i)
      sum += i
    end
  end
  sum
end

 # Метод для проверки, является ли число простым
def prime?(num)
  return false if num < 2
  for i in 2..(num - 1)
    return false if num % i == 0	
  end
  true
end 

# # Метод для нахождения количества нечетных цифр числа, больших 3
# def odd_digits_greater_than_3_count(n)
  # count = 0
  # n_str = n.to_s
  # for i in 0...n_str.length
    # digit = n_str[i].to_i
    # if digit.odd? && digit > 3
      # count += 1
    # end
  # end
  # count
# end

# Метод для нахождения произведения таких делителей числа, сумма цифр которых меньше, чем сумма цифр исходного числа
def product_of_special_divisors(n)
  sum_digits_of_n = sum_of_digits(n)
  product = 1
  has_divisors = false

  for i in 1..n
    if n % i == 0 && sum_of_digits(i) < sum_digits_of_n
      product *= i
      has_divisors = true
    end
  end

  has_divisors ? product : 0
end

# # Метод для нахождения суммы цифр числа
# def sum_of_digits(num)
  # sum = 0
  # num_str = num.to_s
  # for i in 0...num_str.length
    # sum += num_str[i].to_i
  # end
  # sum
# end

# puts "Введите число:"
# number = gets.to_i

# puts "Сумма простых делителей числа #{number}: #{sum_of_prime_divisors(number)}"
# puts "Количество нечетных цифр числа #{number}, больших 3: #{odd_digits_greater_than_3_count(number)}"
# puts "Произведение делителей числа #{number}, сумма цифр которых меньше, чем сумма цифр исходного числа: #{product_of_special_divisors(number)}
