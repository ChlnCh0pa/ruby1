class Student
  attr_accessor :name, :surname, :patronymic, :email, :git, :telegram, :id, :phone

  def initialize(name:, surname:, patronymic:, email:, git:, telegram: nil, id: nil, phone: nil)
    @name = name
    @surname = surname
    @patronymic = patronymic
    @email = email
    @git = git
    @telegram = telegram
    @id = id
    @phone = phone
  end
  
def update_contacts(phone: nil, telegram: nil)
@phone = phone if phone
@telegram = telegram if telegram
end

  def to_s
    "Студент\nID: #{@id}\nИмя: #{@name}\nФамилия: #{@surname}\nОтчество: #{@patronymic}\nEmail: #{@email}\nGit: #{@git}\nТелефон: #{@phone}\nTelegram: #{@telegram}\n----------"
  end
end
