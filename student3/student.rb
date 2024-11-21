class Student
  attr_accessor :name, :surname, :patronymic, :git, :email, :id, :phone, :telegram

  PHONE_REGEX = /^\+\d{11}$/

  def self.valid_phone?(phone)
    phone.match?(PHONE_REGEX)
  end

  def initialize(attributes = {})
    @name = attributes[:name]
    @surname = attributes[:surname]
    @patronymic = attributes[:patronymic]
    @git = attributes[:git]
    @telegram = attributes[:telegram]
    @id = attributes[:id]
    @phone = attributes[:phone]
    @email = attributes[:email]
    validate_phone 
  end

  def to_s
    "Студент\nID: #{@id}\nИмя: #{@name}\nФамилия: #{@surname}\nОтчество: #{@patronymic}\nEmail: #{@email}\nGit: #{@git}\nТелефон: #{@phone}\nTelegram: #{@telegram}\n----------"
  end

  private
  def validate_phone
    if @phone && !self.class.valid_phone?(@phone)
      raise ArgumentError, "Некорректный номер телефона"
    end
  end
  
end