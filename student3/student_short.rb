class StudentShort < BaseStudent
  def initialize(student = nil, id = nil, info = nil)
    if student
      super(id: student.id, git: student.git, email: student.email, phone: student.phone, telegram: student.telegram)
      @surname_and_initials = "#{student.surname} #{student.name[0]}. #{student.patronymic[0]}."
      @contact = student.contact_info
    elsif id && info
      @id = id
      parse_info(info)
    else
      raise ArgumentError, 'Неверные параметры для инициализации'
    end
  end


  def to_s
    "ID: #{@id}, Name: #{@surname_and_initials}, Git: #{@git}, Contact: #{@contact}"
  end

  private

  def parse_info(info)
    parts = info.split(';')
    raise ArgumentError, 'Некорректный формат информации' if parts.size != 3

    name_parts = parts[0].split
    if name_parts.size == 3
      @surname_and_initials = "#{name_parts[0]} #{name_parts[1][0]}. #{name_parts[2][0]}."
    else
      raise ArgumentError, 'Некорректный формат имени'
    end

    @git = parts[1].strip.split(':').last.strip
    @contact = parts[2].strip.split(':').last.strip
  end
end
