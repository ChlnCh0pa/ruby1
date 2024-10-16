class Student
  attr_reader :id, :first_name, :last_name, :middle_name
  attr_accessor :phone, :telegram, :email, :git

  def initialize(id:, last_name:, first_name:, middle_name: nil, **contacts)
    @id = id
    self.last_name = last_name
    self.first_name = first_name
    self.middle_name = middle_name

    # Set contact information based on provided values
    set_contact_info(**contacts)
    validate  # Вызов метода валидации в конструкторе
  end

  # Method to set contact information
  def set_contact_info(phone: nil, telegram: nil, email: nil, git: nil)
    self.phone = phone if phone
    self.telegram = telegram if telegram
    self.git = git if git
    self.email = email if email
  end

  # Method to validate student information
  def validate
    validate_git_presence
    validate_contact_presence
  end

  # Validation for Git presence
  def validate_git_presence
    raise ArgumentError, 'GitHub URL must be present' if git.nil? || git.strip.empty?
  end

  # Validation for at least one contact presence
  def validate_contact_presence
    raise ArgumentError, 'At least one contact (phone, telegram, email) must be present' if phone.nil? && telegram.nil? && email.nil?
  end

  # Class method to check if a string is a valid phone number
  def self.valid_phone_number?(number)
    number.match?(/^(\+\d{1,3})?\d{10}$/)
  end

  # Setter for phone with validation
  def phone=(number)
    raise ArgumentError, 'Invalid phone number format' unless self.class.valid_phone_number?(number)

    @phone = number
  end

  # Validation for last name
  def last_name=(name)
    raise ArgumentError, 'Last name must be a non-empty string' if name.nil? || name.strip.empty?
    @last_name = name
  end

  # Validation for first name
  def first_name=(name)
    raise ArgumentError, 'First name must be a non-empty string' if name.nil? || name.strip.empty?
    @first_name = name
  end

  # Validation for middle name (optional)
  def middle_name=(name)
    if name.nil? || name.strip.empty? || name.match?(/^[A-Za-zа-яёА-ЯЁ]+$/)
      @middle_name = name
    else
      raise ArgumentError, 'Middle name must be a string of letters or nil'
    end
  end

  # Validation for email
  def email=(email)
    raise ArgumentError, 'Invalid email format' unless valid_email?(email)
    @email = email
  end

  # Validation for git
  def git=(git)
    raise ArgumentError, 'Invalid GitHub URL format' unless valid_git?(git)
    @git = git
  end

  # Validation for email format
  def valid_email?(email)
    email.match?(/^[\w+_.-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9.-]+$/)
  end

  # Validation for GitHub URL format
  def valid_git?(git)
    git.match?(/^(https?:\/\/)?(www\.)?github\.com\/[\w-]+\/[\w-]+$/)
  end
end
