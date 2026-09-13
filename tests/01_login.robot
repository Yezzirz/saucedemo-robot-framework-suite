*** Settings ***
Documentation    Suíte de testes de autenticação.
Resource         ../resources/base.robot
Resource         ../resources/pages/login_page.robot
Resource         ../variables/data.robot
Resource         ../resources/pages/inventory_page.robot

Test Setup       Iniciar Sessao
Test Teardown    Encerrar Sessao

*** Test Cases ***
Sauce-1: Login com credenciais validas
    [Tags]    login    smoke
    Quando preenche o usuario "${USER_STANDARD}" e a senha "${PASSWORD_ALL_USERS}"
    E clica no botao de login
    Entao a pagina de produtos deve ser exibida

Sauce-2: Login com credenciais invalidas
    [Tags]    login
    Quando preenche o usuario "${USER_INVALID}" e a senha "${PASSWORD_INVALID}"
    E clica no botao de login
    Entao deve visualizar a mensagem de erro "Epic sadface: Username and password do not match any user in this service"

Sauce-4: Bloquear tentativa de login
    [Tags]    login
    Quando preenche o usuario "${USER_LOCKED_OUT}" e a senha "${PASSWORD_ALL_USERS}"
    E clica no botao de login
    Entao deve visualizar a mensagem de erro "Epic sadface: Sorry, this user has been locked out."