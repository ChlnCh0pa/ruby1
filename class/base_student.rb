class BaseStudent
  attr_reader :id, :surname, :name, :patronymic, :git, :contact

  def initialize(id: nil, surname:, name:, patronymic:, git: nil, contact: nil)

    self.surname = surname
    self.name = name
    self.patronymic = patronymic
    self.git = git
    self.id = id if id
    @contact = contact || "Не указано"  # Исправлено здесь
  end

  def surname=(value)
    validate_name(:surname, value)
    @surname = value
  end

  def name=(value)
    validate_name(:name, value)
    @name = value
  end

  def patronymic=(value)
    validate_name(:patronymic, value)
    @patronymic = value
  end

  def id=(value)
    raise ArgumentError, "Неверный ID: #{value}" unless BaseStudent.id_valid?(value)
    @id = value
  end

  def validate_name(field, value)
    raise ArgumentError, "Неверное значение для #{field}: #{value.inspect}" unless BaseStudent.name_valid?(value)
  end

  def surname_initials
    initials = "#{@surname} "
    initials += "#{@name[0] if @name}" if @name
    initials += ".#{@patronymic[0] if @patronymic}." if @patronymic
    initials
  end

  def self.name_valid?(name)
    return false if name.nil?
    name.match?(/^[А-ЯЁA-Z][а-яёa-z-]+$/)
  end  

  def self.id_valid?(id)
    id.to_s.match?(/^\d+$/)
  end

  def git=(value)
    raise 'Invalid GitHub URL' unless value.nil? || value.match?(/^github\.com\/[\w.-]+$/)
    @git = value
  end

  def git_valid?
    return false if git.nil?
    git.match?(/^github\.com\/[\w.-]+$/)
  end

  def git_null?
    self.git.nil?
  end

  def contact_null?
    self.contact.nil?
  end

  protected def contact=(value)
    @contact = value
  end

  def validate_git_and_contact
    git_null? && contact_null?
  end

  def to_s
    "#{@id} #{@surname} #{@name} #{@patronymic}(Contacts: Git: #{@git} Email: #{@contact || 'N/A'})"
  end
end
  