class Student
  attr_reader :id, :first_name, :last_name, :middle_name
  attr_accessor :git

  def initialize(id:, last_name:, first_name:, middle_name: nil, **contacts)
    @id = id
    self.last_name = last_name
    self.first_name = first_name
    self.middle_name = middle_name

    # Set contact information based on provided values
    set_contacts(**contacts)
    validate  # Вызов метода валидации в конструкторе
  end

  # Method to set contact information
  def set_contacts(phone: nil, telegram: nil, email: nil, git: nil)
    self.phone = phone if phone
    self.telegram = telegram if telegram
    self.git = git if git
    self.email = email if email
  end

  # Метод для установки телефона с валидацией
  def phone=(number)
    raise ArgumentError, 'Invalid phone number format' unless self.class.valid_phone_number?(number)

    @phone = number
  end

  # Метод для установки телеграм-канала
  def telegram=(telegram)
    @telegram = telegram
  end

  # Метод для установки email с валидацией
  def email=(email)
    raise ArgumentError, 'Invalid email format' unless valid_email?(email)
    @email = email
  end

  # Метод для установки GitHub с валидацией
  def git=(git)
    raise ArgumentError, 'Invalid GitHub URL format' unless valid_git?(git)
    @git = git
  end

  # Остальные методы остаются прежними...
  # Методы validate, validate_git_presence, validate_contact_presence и т.д.

end
