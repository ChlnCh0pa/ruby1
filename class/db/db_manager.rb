class StudentsListManager
  def initialize(db_params)
    @db_handler = DatabaseHandler.new(db_params)
  end

  def close
    @db_handler.close
  end

  def get_student_by_id(id)
    @db_handler.get_student_by_id(id)
  end

  def get_k_n_student_short_list(k, n)
    @db_handler.get_k_n_student_short_list(k, n)
  end

  def add_student(new_student)
    @db_handler.add_student(new_student)
  end

  def replace_student_by_id(id, updated_student)
    @db_handler.replace_student_by_id(id, updated_student)
  end

  def delete_student_by_id(id)
    @db_handler.delete_student_by_id(id)
  end

  def get_student_count
    @db_handler.get_student_count
  end
end
