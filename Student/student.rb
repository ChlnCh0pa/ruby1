class Student
  attr_reader :id, :first_name, :last_name, :middle_name, :git

  def initialize(id, last_name, first_name, middle_name = nil, phone = nil, telegram = nil, email = nil, git = nil)
    @id = id
    @last_name = last_name
    @first_name = first_name
    @middle_name = middle_name
    @phone = phone
    @telegram = telegram
    @github = git
    @email = email
  end

  def last_name=(last_name)
    @last_name = last_name
  end

  def first_name=(first_name)
    @first_name = first_name
  end

  def middle_name=(middle_name)
    @middle_name = middle_name
  end

  def phone=(phone)
    @phone = phone
  end

  def telegram=(telegram)
    @telegram = telegram
  end

  def email=(email)
    @email = email
  end

  def git=(git)
    @github = git
  end

  def phone
    @phone
  end

  def telegram
    @telegram
  end

  def email
    @email
  end
end
