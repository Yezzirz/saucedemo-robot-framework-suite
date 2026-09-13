*** Settings ***
Documentation    Arquivo base do projeto contendo hooks de Setup e Teardown.
Library          Browser

*** Variables ***
${BASE_URL}      https://www.saucedemo.com
${BROWSER}       chromium
${HEADLESS}      false

*** Keywords ***
Iniciar Sessao
    New Browser    browser=${BROWSER}    headless=${HEADLESS}
    New Context    viewport={'width': 1280, 'height': 720}
    New Page       ${BASE_URL}

Encerrar Sessao
    Close Browser

Fazer Login E2E
    [Arguments]    ${username}=standard_user    ${password}=secret_sauce
    Iniciar Sessao
    Type Text      css=#user-name    ${username}
    Type Text      css=#password     ${password}
    Click          css=#login-button
    Get Text       css=.title    ==    Products