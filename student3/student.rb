class Student
  attr_accessor :name, :surname, :patronymic, :git, :email
  attr_reader :id, :phone, :telegram

  PHONE_REGEX = /^\+\d{11}$/
  NAME_REGEX = /^[A-Za-zА-Яа-я]+$/
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  GIT_REGEX = /^https:\/\/github\.com\/\w+$/
  TELEGRAM_REGEX = /^@\w+$/

  FIELD_VALIDATORS = {
    name: :valid_name?,
    surname: :valid_name?,
    patronymic: :valid_name?,
    email: :valid_email?,
    git: :valid_git?,
    phone: :valid_phone?,
    telegram: :valid_telegram?
  }

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

  def initialize(attributes = {})
    @id = attributes[:id]
    @name = attributes[:name]
    @surname = attributes[:surname]
    @patronymic = attributes[:patronymic]
    @git = attributes[:git]
    @phone = attributes[:phone]
    @telegram = attributes[:telegram]
    @contacts = {
      email: attributes[:email],
      phone: attributes[:phone],
      telegram: attributes[:telegram]
    }
    @contacts[:email] &&= attributes[:email]
    validate_fields
    validate
  end

  def set_contacts(contacts)
    @contacts[:email] = contacts[:email] if contacts[:email]
    @contacts[:phone] = contacts[:phone] if contacts[:phone]
    @contacts[:telegram] = contacts[:telegram] if contacts[:telegram]
    validate_contact_presence
  end

  def to_s
    "Студент\nID: #{@id}\nИмя: #{@name}\nФамилия: #{@surname}\nОтчество: #{@patronymic}\nEmail: #{@contacts[:email]}\nGit: #{@git}\nТелефон: #{@contacts[:phone]}\nTelegram: #{@contacts[:telegram]}\n----------"
  end

  def get_info
    "#{surname} #{name[0]}. #{patronymic[0]}.; Git: #{@git}; Контакт: #{contact_info}"
  end

  def surname_and_initials
    "#{surname} #{name[0]}. #{patronymic[0]}."
  end

  def git_info
    @git
  end

  def contact_info
    if @contacts[:email]
      "Email: #{@contacts[:email]}"
    elsif @contacts[:phone]
      "Phone: #{@contacts[:phone]}"
    elsif @contacts[:telegram]
      "Telegram: #{@contacts[:telegram]}"
    else
      "Нет контакта"
    end
  end

  private

  def validate_fields
    self.class::FIELD_VALIDATORS.each do |field, method|
      validate_field(field, method)
    end
  end

  def validate_field(field, validation_method)
    value = field == :email ? @contacts[:email] : instance_variable_get("@#{field}")
    if value && !self.class.send(validation_method, value)
      raise ArgumentError, "Ошибка: #{field}: #{value}"
    end
  end

  def validate
    validate_git_presence
    validate_contact_presence
  end

  def validate_git_presence
    if @git.nil? || @git.empty?
      raise ArgumentError, "Git обязателен"
    end
  end

  def validate_contact_presence
    if @contacts[:email].nil? && @contacts[:phone].nil? && @contacts[:telegram].nil?
      raise ArgumentError, "Необходим хотя бы один способ связи"
    end
  end
end
