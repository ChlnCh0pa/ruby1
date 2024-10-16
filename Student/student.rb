class Student
  attr_reader :id, :first_name, :last_name, :middle_name, :email  # Добавлено :email в attr_reader
  attr_accessor :git

  def initialize(id:, last_name:, first_name:, middle_name: nil, **contacts)
    @id = id
    self.last_name = last_name
    self.first_name = first_name
    self.middle_name = middle_name

    set_contacts(**contacts)
    validate  # Вызов метода валидации в конструкторе
  end

  # Метод для установки фамилии
  def last_name=(name)
    @last_name = name
  end

  # Метод для установки имени
  def first_name=(name)
    @first_name = name
  end

  # Метод для установки отчества
  def middle_name=(name)
    @middle_name = name
  end

  # Метод для установки email с валидацией
  def email=(email)
    raise ArgumentError, 'Invalid email format' unless self.class.valid_email?(email)
    @email = email
  end

  # Метод для получения email
  def email
    @email
  end

  # Метод для установки телефонного номера с валидацией
  def phone=(number)
    raise ArgumentError, 'Invalid phone number format' unless self.class.valid_phone_number?(number)
    @phone = number
  end

  # Метод для получения телефонного номера
  def phone
    @phone
  end

  # Метод для установки телеграм-канала
  def telegram=(telegram)
    @telegram = telegram
  end

  # Метод для получения телеграм-канала
  def telegram
    @telegram
  end

  # Метод для установки контактной информации
  def set_contacts(phone: nil, telegram: nil, email: nil, git: nil)
    self.phone = phone if phone
    self.telegram = telegram if telegram
    self.git = git if git
    self.email = email if email
  end

  # Метод валидации
  def validate
    raise ArgumentError, 'Missing required contact information' unless valid_contact_presence?
  end

  # Метод для проверки наличия хотя бы одного контакта
  def valid_contact_presence?
    !@phone.nil? || !@telegram.nil? || !@email.nil? || !@git.nil?
  end

  # Метод для проверки корректности формата номера телефона
  def self.valid_phone_number?(number)
    number =~ /^\+\d{10,15}$/
  end

  # Метод для проверки корректности формата электронной почты
  def self.valid_email?(email)
    email =~ /^[^\s@]+@[^\s@]+\.[^\s@]+$/ if email
  end

  # Метод для проверки корректности формата URL GitHub
  def self.valid_git?(git)
    git =~ /^https?:\/\/github\.com\/[\w-]+\/[\w-]+$/
  end
end
