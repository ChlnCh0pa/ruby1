class Student < BaseStudent
  attr_accessor :name, :surname, :patronymic, :git, :email
  attr_reader :phone, :telegram

  def initialize(attributes = {})
    @name = attributes[:name]
    @surname = attributes[:surname]
    @patronymic = attributes[:patronymic]
    super(attributes)
  end

  def to_s
    "Студент\nID: #{@id}\nИмя: #{@name}\nФамилия: #{@surname}\nОтчество: #{@patronymic}\nEmail: #{@contacts[:email]}\nGit: #{@git}\nТелефон: #{@contacts[:phone]}\nTelegram: #{@contacts[:telegram]}\n----------"
  end

  def get_info
    "#{surname} #{name[0]}. #{patronymic[0]}.; Git: #{@git}; Контакт: #{contact_info}\n----------"
  end

  def surname_and_initials
    "#{surname} #{name[0]}. #{patronymic[0]}\n----------."
  end

  def git_info
    @git
  end
end
