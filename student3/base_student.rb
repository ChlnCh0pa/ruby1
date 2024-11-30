class BaseStudent
  attr_reader :id, :surname, :name, :patronymic, :git, :contact

  def initialize(id: nil, surname:, name:, patronymic:, git:, contact: nil)
    self.surname = surname
    self.name = name
    self.patronymic = patronymic
    self.git = git if git
    self.id = id if id
    self.contact = contact if contact
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

  def git=(value)
    raise ArgumentError, "Неверный Git: #{value}" unless BaseStudent.git_valid?(value)
    @git = value
  end

 
  def validate_name(field, value)
    raise ArgumentError, "Неверное значение для #{field}: #{value}" unless BaseStudent.name_valid?(value)
  end

  
  def self.name_valid?(name)
    name.match?(/^[А-ЯЁA-Z][а-яёa-z-]+$/)
  end


  def self.id_valid?(id)
    id.to_s.match?(/^\d+$/)
  end


  def self.git_valid?(git)
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


  def short_name
    "#{surname} #{name[0]}.#{patronymic[0]}."
  end

  def git_info
    self.git
  end  

  def to_s
    "#{@id} #{@surname} #{@name} #{@patronymic}(Contacts: Git: #{@git} Email: #{@email} Phone: #{@phone || 'N/A'} Telegram: #{@telegram || 'N/A'})"
  end
end