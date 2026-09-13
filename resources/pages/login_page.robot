*** Settings ***
Documentation    Ações e elementos da página de login.
Library          SeleniumLibrary

*** Variables ***
${INPUT_USER}       css=#user-name
${INPUT_PASS}       css=#password
${BTN_LOGIN}        css=#login-button
${BANNER_ERROR}     css=[data-test="error"]

*** Keywords ***
Dado que o usuario acessa a pagina de login
    Go To    ${BASE_URL}
    Wait Until Element Is Visible    ${INPUT_USER}    timeout=10s

Quando preenche o usuario "${username}" e a senha "${password}"
    Wait Until Element Is Visible    ${INPUT_USER}    timeout=10s
    IF    '${username}' != '${EMPTY}'    Input Text    ${INPUT_USER}    ${username}
    IF    '${password}' != '${EMPTY}'    Input Password    ${INPUT_PASS}    ${password}

E clica no botao de login
    Wait Until Element Is Enabled    ${BTN_LOGIN}     timeout=10s
    Click Button                     ${BTN_LOGIN}

Entao deve visualizar a mensagem de erro "${mensagem_esperada}"
    Wait Until Element Is Visible    ${BANNER_ERROR}   timeout=10s
    Element Text Should Be           ${BANNER_ERROR}   ${mensagem_esperada}