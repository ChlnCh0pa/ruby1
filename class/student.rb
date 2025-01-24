require_relative 'base_student'
require 'date'

class Student < BaseStudent
  attr_reader :phone, :telegram, :email, :birth_date


  def initialize(attributes = {})
    set_contacts(phone: attributes[:phone], telegram: attributes[:telegram], email: attributes[:email])
    self.birth_date = attributes[:birth_date] if attributes[:birth_date]
    super(surname: attributes[:surname], name: attributes[:name], patronymic: attributes[:patronymic], git: attributes[:git], id: attributes[:id], contact: contact)
  end


  def self.birth_date_valid?(date)
    return true if date.is_a?(Date)
    Date.parse(date.to_s) rescue false
  end

  # Установка даты рождения с валидацией
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


  def to_h
    {
      id: @id,
      surname: @surname,
      name: @name,
      patronymic: @patronymic,
      git: @git,
      phone: @phone,
      telegram: @telegram,
      email: @email,
      birth_date: @birth_date.to_s
    }
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
