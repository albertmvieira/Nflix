class MovieAdd
  include Capybara::DSL

  def create(movie)
    find("input[name=title]").set movie["title"]

    select_status(movie["status"]) unless movie["status"].empty?

    find("input[name=year]").set movie["year"]
    find("input[name=release_date]").set movie["release_date"]

    add_cast(movie["cast"])

    find("textarea[name=overview]").set movie["overview"]

    # executará apenas se movie.cover não estiver vazio (executa se retornar false)
    # if executaria se fosse verdadeira a condição e unless se for false
    upload(movie["cover"]) unless movie["cover"].empty?

    find("#create-movie").click
  end

  def alert
    find(".alert").text
  end

  def upload(file)
    cover_file = File.join(Dir.pwd, "features/support/fixtures/cover/" + file)

    #função tr do ruby funciona como replace do java (pega string e modifica para o valor desejado)
    #alterando barra para padrão windows
    #if retorna true or false - só executará se for windows (utilizando a gem OS)
    cover_file = cover_file.tr("/", "\\") if OS.windows?

    #desabilitando a config do capybara que respeita elementos oculta no css da pagina, desta forma será possível manipular o input da imagem
    Capybara.ignore_hidden_elements = false
    attach_file("upcover", cover_file)
    Capybara.ignore_hidden_elements = true
  end

  def add_cast(cast)
    actor = find(".input-new-tag")
    cast.each do |a|
      actor.set a
      actor.send_keys :tab
    end
  end

  def select_status(status)
    #Combobox - customizado com lis
    find("input[placeholder=Status]").click
    find(".el-select-dropdown__item", text: status).click
  end
end
