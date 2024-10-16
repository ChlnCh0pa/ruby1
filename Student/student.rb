class Student
  attr_reader :id, :first_name, :last_name, :middle_name
  attr_accessor :phone, :telegram, :email, :git

  def initialize(id, last_name, first_name, middle_name = nil, **contacts)
    @id = id
    @last_name = last_name
    @first_name = first_name
    @middle_name = middle_name

    # Set contact information based on provided values
    set_contact_info(**contacts)
  end

  # Method to set contact information
  def set_contact_info(phone: nil, telegram: nil, email: nil, git: nil)
    self.phone = phone if phone
    self.telegram = telegram if telegram
    self.git = git if git
    self.email = email if email
  end
end
