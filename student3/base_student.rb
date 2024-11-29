class BaseStudent
  attr_reader :id, :surname_and_initials, :git, :contact, :email

  def initialize(id:, surname_and_initials:, git:, contact: nil, email: nil)
    @id = id
    @surname_and_initials = surname_and_initials
    @git = git
    @contact = contact
    @email = email
  end
  def surname_and_initials=(value)
    validate_name(:surname_and_initials, value)
    @surname_and_initials = value
  end

  def id=(value)
    raise ArgumentError, "Неверный ID: #{value}" unless valid_id?(value)
    @id = value
  end

  def git=(value)
    raise ArgumentError, "Неверный Git: #{value}" unless valid_git?(value)
    @git = value
  end

  def contact=(value)
    raise ArgumentError, "Неверный контакт: #{value}" unless valid_contact?(value)
    @contact = value
  end

  def contact_info
    if @contact
      "Контакт: #{@contact}"
    else
      "Нет контакта"
    end
  end

  private

  def validate_name(field, value)
    raise ArgumentError, "Неверное значение для #{field}: #{value}" unless value.match?(/^[А-ЯЁA-Z][а-яёa-z-]+$/)
  end

  def valid_id?(id)
    id.to_s.match?(/^\d+$/)
  end

  def valid_git?(git)
    git.match?(/^https:\/\/github\.com\/[\w.-]+$/)
  end

  def valid_contact?(contact)
    contact.match?(/^[\w+.-]+@[a-z\d.-]+\.[a-z]+$/) || contact.match?(/^\+\d{11}$/) || contact.match?(/^@\w+$/)
  end
end