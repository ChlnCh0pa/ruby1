require_relative 'C:/Users/Sergey/AppData/Local/GitHubDesktop/ruby/class/student_list_controller.rb'
require_relative 'C:/Users/Sergey/AppData/Local/GitHubDesktop/ruby/class/app.rb'
app = FXApp.new
main_window = MainApp.new(app)
main_window.show(PLACEMENT_SCREEN)
app.create
app.run