require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')
LANGUAGE = 'ru'

def messages(message, lang='en')
  MESSAGES[lang][message]
end

def prompt(key)
  message = messages(key, LANGUAGE)
  puts("=> #{message}")
end

def valid_number?(num)
  integer?(num) || float?(num)
end

def integer?(num)
  num.to_i.to_s == num
end

def float?(num)
  num.to_f.to_s == num
end

def operation_to_message(op)
  word = case op
         when '1'
           'add'
         when '2'
           'sub'
         when '3'
           'mult'
         when '4'
           'div'
         end

  word
end

prompt('welcome')

name = ''
loop do
  name = gets().chomp()

  if name.empty?()
    prompt('valid_name')
  else
    break
  end
end

if LANGUAGE == 'en'
  puts("Hi #{name}!")
else
  puts("Здравствуйте #{name}!")
end

loop do # main loop
  number1 = ''
  loop do
    prompt('first_number')
    number1 = gets().chomp()

    if valid_number?(number1)
      break
    else
      prompt('valid_number')
    end
  end

  number2 = ''
  loop do
    prompt('second_number')
    number2 = gets().chomp()

    if valid_number?(number2)
      break
    else
      prompt('valid_number')
    end
  end

  prompt('operator_prompt')
  operator = ''
  loop do
    operator = gets().chomp()

    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt('operator_options')
    end
  end

  
  prompt(operation_to_message(operator))

  result = case operator
           when '1'
             number1.to_i() + number2.to_i()
           when '2'
             number1.to_i() - number2.to_i()
           when '3'
             number1.to_i() * number2.to_i()
           when '4'
             number1.to_f() / number2.to_f()
           end

             
  if LANGUAGE == 'en'
    puts("The result is: #{result}!")
  else
    puts("Результат: #{result}!")
  end


  prompt('repeat_calculation')
  answer = gets().chomp()
  break unless answer.downcase().start_with?('y')      
end
prompt('goodbye')