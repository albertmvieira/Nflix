module Helpers
  def get_token
    #Repete a quandidade de vezes informando a quantidade na chamada do metodo times. Neste caso 2x por causa do retorno do wait time do capybara
    2.times do
      #Gravando comando javaScript (para pegar valor de um atributo no storage local) na variável
      js_script = 'return window.localStorage.getItem("default_auth_token");'
      #Executando java script com capybara
      @token = page.execute_script(js_script)
      sleep 1
      break if @token != nil
    end
    @token
  end
end
