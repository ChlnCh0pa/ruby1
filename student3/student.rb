class Student
attr_accessor :name, :surname, :patronymic, :git, :email, :id, :phone, :tlegram
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



 

def to_s
"Студент\nID: #{@id}\nИмя: #{@name}\nФамилия: #{@surname}\nОтчество: #{@patronymic}\nEmail: #{@email}\nGit: #{@git}\nТелефон: #{@phone}\nTelegram: #{@telegram}\n----------"
  end

 
end
