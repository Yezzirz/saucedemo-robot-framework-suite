*** Settings ***
Documentation    Ações e elementos da página de login.
Library          Browser
Resource         ../base.robot

*** Variables ***
${INPUT_USER}       css=#user-name
${INPUT_PASS}       css=#password
${BTN_LOGIN}        css=#login-button
${BANNER_ERROR}     css=[data-test="error"]

*** Keywords ***
Dado que o usuario acessa a pagina de login
    Go To    ${BASE_URL}

Quando preenche o usuario "${username}" e a senha "${password}"
    Type Text    ${INPUT_USER}    ${username}
    Type Text    ${INPUT_PASS}    ${password}

E clica no botao de login
    Click        ${BTN_LOGIN}

Entao deve visualizar a mensagem de erro "${mensagem_esperada}"
    Get Text     ${BANNER_ERROR}    ==    ${mensagem_esperada}