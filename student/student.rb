class Student
attr_accessor :name, :surname, :patronymic, :emai:, :git, :telegram, :id, :phone
def initialize(name:, surname:, patronymic:, email:, git:, telegram: nil, id: nil, phone: nil) 

@name = name
@surname = surname
@patronymic = patronymic
@emai = email
@git = git
@telegram = telegram
@id = id
@phone = phone
end
end