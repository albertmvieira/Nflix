#language: pt

Funcionalidade: Login

Para que eu possa gerenciar os filmes do catálogo Ninjaflix
Sendo um usuário previamente cadastrado
Posso acessar o sistema com o meu email e senha

@login_happy
Cenário: Acesso
Quando eu faço login com "tony@stark.com" e "pwd123"
Então devo ser autenticado
E devo ver "Tony Stark" na área logada

@login_hapless
Esquema do Cenario: Login sem sucesso
    Quando eu faço login com <email> e <senha>
    Então não devo ser autenticado
    E devo ver a mensagem de alerta <msg>

    Exemplos:
    | email            | senha    | msg                            |
    | "tony@stark.com" | "abc123" | "Usuário e/ou senha inválidos" |
    | "404@yahoo.com"  | "abc123" | "Usuário e/ou senha inválidos" |
    | ""               | "abc123" | "Opps. Cadê o email?"          |
    | "tony@stark.com" | ""       | "Opps. Cadê a senha?"          |