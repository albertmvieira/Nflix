require "report_builder"
require "date"

Before do
  @login_page = LoginPage.new
  @movie_page = MoviePage.new
  @sidebar = SideBarView.new

  # page.driver.browser.manage.window.maximize
  # a estratégia de definir uma resolução mínima é melhor do que maximizar.
  page.current_window.resize_to(1440, 900)
end

Before("@login") do
  user = CONFIG["users"]["cat_manager"]
  @login_page.go
  @login_page.with(user["email"], user["pass"])
end

After do
  temp_shot = page.save_screenshot("log/temp_shot.png")
  image = open(temp_shot, "rb", &:read)
  encode_image = Base64.encode64(image)
  embed(encode_image, "image/png;base64", "Screenshot")
  #  Não funcionou o codigo abaixo
  # screenshot = Base64.encode64(File.open(temp_shot, "rb").read)
  #  embed(encode_image, "image/png", "Screenshot")
end

d = DateTime.now

# convertendo data para string e substituindo : por -
@current_date = d.to_s.tr(":", "-")

#at_exit faz que trecho do código só execute no final da execução do cucuber como um todo
at_exit do
  ReportBuilder.configure do |config|
    config.input_path = "log/report.json"
    config.report_path = "log/" + @current_date
    config.report_types = [:retry, :html]
    config.report_title = "NinjaFlix - WebApp"
    config.compress_image = true
    config.additional_info = { "App" => "Web", "Data de execução" => @current_date }
    config.color = "indigo"
  end
  ReportBuilder.build_report
end
