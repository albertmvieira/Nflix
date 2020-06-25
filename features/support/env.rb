require "capybara"
require "capybara/cucumber"
require "selenium-webdriver"
require "os"

#chamnado o modulo helper
require_relative "helpers"

#usando 'World' todos os recursos do módulo helpers será nativo dentro da execução do cucumber
World(Helpers)

# Variável de ambiente - para criar variavel de ambiente global é necessário informar ENV[] e ser em letra maiuscula
#CONFIG carrega o arquivo de ambiente da pasta config
CONFIG = YAML.load_file(File.join(Dir.pwd, "features/support/config/#{ENV["ENV_TYPE"]}.yaml"))

case ENV["BROWSER"]
when "firefox"
  @driver = :selenium
when "chrome"
  @driver = :selenium_chrome
when "headless"
  @driver = :selenium_chrome_headless
else
  puts "Invalid Browser"
end

Capybara.configure do |config|
  config.default_driver = @driver
  config.default_max_wait_time = 10
  config.app_host = CONFIG["url"]
end
