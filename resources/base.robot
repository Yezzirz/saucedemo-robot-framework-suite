*** Settings ***
Documentation    Arquivo base do projeto contendo hooks de Setup e Teardown.
Library          SeleniumLibrary
Resource         ../variables/data.robot

*** Variables ***
${BASE_URL}      https://www.saucedemo.com
${BROWSER}       chrome
${SPEED}         0s

*** Keywords ***
Iniciar Sessao
    # Instancia opções e abre o Chrome em modo Anônimo (--incognito)
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    Call Method    ${options}    add_argument    --incognito
    Call Method    ${options}    add_argument    --no-sandbox
    Call Method    ${options}    add_argument    --disable-dev-shm-usage

    Open Browser                  ${BASE_URL}    ${BROWSER}    options=${options}
    Maximize Browser Window
    Set Selenium Timeout          10s
    Set Selenium Speed            ${SPEED}

Encerrar Sessao
    Close Browser

Fazer Login E2E
    [Arguments]    ${username}=standard_user    ${password}=secret_sauce
    Iniciar Sessao
    Wait Until Element Is Visible    css=#user-name    timeout=10s
    Input Text                       css=#user-name    ${username}
    Input Password                   css=#password     ${password}
    Click Button                     css=#login-button
    Wait Until Element Is Visible    css=.title        timeout=10s
    Element Text Should Be           css=.title        Products