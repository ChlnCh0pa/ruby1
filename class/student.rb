require_relative 'base_student'
class Student < BaseStudent
  attr_reader :phone, :telegram, :email, :birth_date

  def initialize(id: nil, surname:, name:, patronymic:, git: nil, phone: nil, telegram: nil, email: nil, birth_date: nil)
    set_contacts(phone: phone, telegram: telegram, email: email)
    self.birth_date = birth_date if birth_date
    super(surname: surname, name: name, patronymic: patronymic, git: git, id: id, contact: contact)
  end

  def self.birth_date_valid?(date)
    return true if date.is_a?(Date)
    Date.parse(date.to_s) rescue false
  end

  def birth_date=(date)
    raise ArgumentError, 'Некорректная дата рождения' unless self.class.birth_date_valid?(date)
    @birth_date = date.is_a?(Date) ? date : Date.parse(date)
  end

  def set_contacts(phone: nil, telegram: nil, email: nil)
    self.phone = phone if phone
    self.telegram = telegram if telegram
    self.email = email if email
    self.contact = "#{self.phone || self.telegram || self.email || nil}"
  end

  def self.phone_valid?(phone)
    phone.to_s.match?(/^(\d{11}|\+\d{11})$/)
  end

  def self.telegram_valid?(telegram)
    telegram.match?(/^@[\w]+$/)
  end

  def self.email_valid?(email)
    email.match?(/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i)
  end

  def get_info
    "Инициалы: #{surname_initials}; Git: #{self.git};  Контакты: #{self.contact}"
  end

  def to_s
    details = []
    details << super
    details << "Phone: #{@phone}" if @phone
    details << "Telegram: #{@telegram}" if @telegram
    details << "Mail: #{@email}" if @email
    details.join("\n")
  end

  

  private

  def phone=(phone)
    if phone.nil? || Student.phone_valid?(phone)
      @phone = phone
    else
      raise ArgumentError, "Неверный телефон: #{id} #{surname} #{name}"
    end
  end

  def telegram=(telegram)
    if telegram.nil? || Student.telegram_valid?(telegram)
      @telegram = telegram
    else
      raise ArgumentError, "Неверный Telegram: #{id} #{surname} #{name}"
    end
  end

  def email=(email)
    if email.nil? || Student.email_valid?(email)
      @email = email
    else
      raise ArgumentError, "Неверный адрес электронной почты: #{id} #{surname} #{name}"
    end
  end
end