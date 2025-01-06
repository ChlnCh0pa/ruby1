class StudentShortInfo < BaseStudent
  def initialize(id:, git:, contact:, surname_initials:)
    @id = id
    @git = git
    @contact = contact
    @surname_initials = surname_initials
  end


  def self.new_from_student(student)
    self.new(
      id: student.id,
      git: student.git,
      contact: student.contact,
      surname_initials: student.surname_initials
      )
  end

  def self.new_from_string(id:, str:)
    student_short_init = {}
    params = split(str)
    student_short_init[:id] = id
    student_short_init[:surname_initials] = params[0]
    student_short_init[:git] = params[1]
    student_short_init[:contact] = params[2..].join(' ')  
    self.new(**student_short_init)
  end

  def self.split(str)
    str.split(/,|; /)  
  end

  private_class_method :new

  def to_s
    details = []
    details << "ID: #{@id}" if @id
    details << "Surname and initials: #{@surname_initials}"
    details << "GitHub: #{@git}" if @git
    details << "Contacts: #{@contact}" if @contact
    details.join("\n")
  end
end
