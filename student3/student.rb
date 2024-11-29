class Student < BaseStudent
  attr_accessor :name, :surname, :patronymic, :git, :email
  attr_reader :phone, :telegram

  def initialize(id:, name:, surname:, patronymic:, git:, email:, phone: nil, telegram: nil)

    super(id: id, surname_and_initials: "#{surname} #{name[0]}. #{patronymic[0]}.", git: git, contact: phone || telegram || email)
    @name = name
    @surname = surname
    @patronymic = patronymic
    @phone = phone
    @telegram = telegram
  end

  def to_s

    "#{@id} #{@surname} #{@name} #{@patronymic}(Git: #{@git} Email: #{@email} Phone: #{@phone || 'N/A'}Telegram: #{@telegram || 'N/A'})\n----------"
  end


  def get_info
    "#{surname} #{name[0]}. #{patronymic[0]}.; Git: #{@git || nil}; Контакт: #{contact_info || nil}\n----------"
  end

  def surname_and_initials
    "#{surname} #{name[0]}. #{patronymic[0] || nil}\n----------."
  end

  def git_info
    @git || nil
  end

  def set_contacts(phone: nil, telegram: nil, email: nil)
    self.phone = phone if phone
    self.telegram = telegram if telegram
    self.email = email if email

   
    self.contact = nil
    contact_info = []
    contact_info << "Телефон: #{phone}" if phone
    contact_info << "Телеграм: #{telegram}" if telegram
    contact_info << "Почта: #{email}" if email
    self.contact = contact_info.join(', ') unless contact_info.empty?
  end

  def phone=(phone)
    if phone.nil? || Student.phone_valid?(phone)
      @phone = phone
    else
      raise ArgumentError, "Неверный телефон: #{@id} #{@surname} #{@name}"
    end
  end

  def telegram=(telegram)
    if telegram.nil? || Student.telegram_valid?(telegram)
      @telegram = telegram
    else
      raise ArgumentError, "Неверный Telegram: #{@id} #{@surname} #{@name}"
    end
  end

  def email=(email)
    if email.nil? || Student.email_valid?(email)
      @email = email
    else
      raise ArgumentError, "Неверный адрес электронной почты: #{@id} #{@surname} #{@name}"
    end
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

  def contact_info
    if @phone
      "Телефон: #{@phone}"
    elsif @telegram
      "Телеграм: #{@telegram}"
    elsif @email
      "Почта: #{@email}"
    else
      nil
    end
  end
end
