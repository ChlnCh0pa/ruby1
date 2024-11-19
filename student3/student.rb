class Student
def initialize (name:, surname:, patronymic:, git:, email:, id: nil, phone: nil, telegram: nil)
@name = name
@surname = surname
@patronymic = patronymic
@git = git
@email = email
@id = id 
@phone = phone 
@telegram = telegram
end



 def name 
@name
end 

def name=(value)
@name = value
end

def surname
@surname
end

def surname=(value)
@surname = value
end

def patronymic
@patronymic
end

def patronymic=(value)
@patronymic = value
end

def git
@git
end

def git=(value)
@git = value
end


def email
@email
end

def email=(value)
@email = value
end

def phone
@phone
end

def phone=(value)
@phone = value
end

def telegram
@telegram
end

def telegram=(value)
@telegram = value
end

def id
@id
end

def id=(value)
@id = value
end



 
end
