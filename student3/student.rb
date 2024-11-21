class Student
  attr_accessor :name, :surname, :patronymic, :git, :email, :phone, :telegram
  attr_reader :id

  PHONE_REGEX = /^\+\d{11}$/
  NAME_REGEX = /^[A-Za-zА-Яа-я]+$/
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  GIT_REGEX = /^https:\/\/github\.com\/\w+$/
  TELEGRAM_REGEX = /^@\w+$/

  def self.valid_phone?(phone)
    phone.match?(PHONE_REGEX)
  end

  def self.valid_name?(name)
    name.match?(NAME_REGEX)
  end

  def self.valid_email?(email)
    email.match?(EMAIL_REGEX)
  end

  def self.valid_git?(git)
    git.match?(GIT_REGEX)
  end

  def self.valid_telegram?(telegram)
    telegram.match?(TELEGRAM_REGEX)
  end

  FIELD_VALIDATORS = {
    name: :valid_name?,
    surname: :valid_name?,
    patronymic: :valid_name?,
    email: :valid_email?,
    git: :valid_git?,
    phone: :valid_phone?,
    telegram: :valid_telegram?
  }

  def initialize(attributes = {})
    @name = attributes[:name]
    @surname = attributes[:surname]
    @patronymic = attributes[:patronymic]
    @git = attributes[:git]
    @telegram = attributes[:telegram]
    @id = attributes[:id]
    @phone = attributes[:phone]
    @email = attributes[:email]
    validate_fields
  end

  def to_s
    "Студент\nID: #{@id}\nИмя: #{@name}\nФамилия: #{@surname}\nОтчество: #{@patronymic}\nEmail: #{@email}\nGit: #{@git}\nТелефон: #{@phone}\nTelegram: #{@telegram}\n----------"
  end

  private
  def validate_fields
    FIELD_VALIDATORS.each do |field, method|
      validate_field(field, method)
    end
  end

  def validate_field(field, validation_method)
    value = instance_variable_get("@#{field}")
    if value && !self.class.send(validation_method, value)
      raise ArgumentError, "Invalid #{field}: #{value}"
    end
  end
end
