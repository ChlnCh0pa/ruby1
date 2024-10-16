class Student
  attr_reader :id, :first_name, :last_name, :middle_name, :git, :phone, :telegram, :email

  def initialize(id, last_name, first_name, middle_name = nil, contacts = {})
    @id = id
    @last_name = last_name
    @first_name = first_name
    @middle_name = middle_name
    set_contact_info(contacts)
  end

  # Метод для установки контактной информации
  def set_contact_info(contacts = {})
    @phone = contacts[:phone] if contacts[:phone]
    @telegram = contacts[:telegram] if contacts[:telegram]
    @github = contacts[:git] if contacts[:git]
    @email = contacts[:email] if contacts[:email]
  end
end
