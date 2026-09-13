*** Settings ***
Documentation    Suíte de testes de autenticação (Sauce-1 até Sauce-4).
Resource         ../resources/base.robot
Resource         ../resources/pages/login_page.robot
Resource         ../resources/pages/inventory_page.robot

Test Setup       Iniciar Sessao
Test Teardown    Encerrar Sessao

*** Test Cases ***
Sauce-1: Login com credenciais validas
    [Tags]    login    smoke
    Quando preenche o usuario "standard_user" e a senha "secret_sauce"
    E clica no botao de login
    Entao a pagina de produtos deve ser exibida

Sauce-2: Login com credenciais invalidas
    [Tags]    login
    Quando preenche o usuario "invalid_user" e a senha "invalid_pass"
    E clica no botao de login
    Entao deve visualizar a mensagem de erro "Epic sadface: Username and password do not match any user in this service"

Sauce-3: Validacao de campos obrigatorios
    [Tags]    login
    Quando preenche o usuario "${EMPTY}" e a senha "${EMPTY}"
    E clica no botao de login
    Entao deve visualizar a mensagem de erro "Epic sadface: Username is required"

Sauce-4: Bloquear tentativa de login
    [Tags]    login
    Quando preenche o usuario "locked_out_user" e a senha "secret_sauce"
    E clica no botao de login
    Entao deve visualizar a mensagem de erro "Epic sadface: Sorry, this user has been locked out."