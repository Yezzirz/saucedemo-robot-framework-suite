*** Settings ***
Documentation    Ações e elementos do fluxo de carrinho e checkout.
Library          SeleniumLibrary

*** Variables ***
${BTN_CHECKOUT}           css=[data-test="checkout"]
${BTN_CONTINUE_SHOPPING}    css=[data-test="continue-shopping"]
${BTN_CONTINUE}           css=[data-test="continue"]
${BTN_FINISH}             css=[data-test="finish"]
${INPUT_FIRST_NAME}       css=#first-name
${INPUT_LAST_NAME}        css=#last-name
${INPUT_POSTAL_CODE}      css=#postal-code
${ERROR_CHECKOUT}         css=[data-test="error"]

*** Keywords ***
Clicar Em Checkout
    Wait Until Element Is Visible    ${BTN_CHECKOUT}    timeout=10s
    Click Button    ${BTN_CHECKOUT}

Clicar Em Continue Shopping
    Wait Until Element Is Visible    ${BTN_CONTINUE_SHOPPING}    timeout=10s
    Click Button    ${BTN_CONTINUE_SHOPPING}

Preencher Formulario De Checkout
    [Arguments]    ${first_name}=${EMPTY}    ${last_name}=${EMPTY}    ${postal_code}=${EMPTY}
    Wait Until Element Is Visible    ${INPUT_FIRST_NAME}    timeout=10s

    IF    '${first_name}' != '${EMPTY}'    Input Text    ${INPUT_FIRST_NAME}    ${first_name}
    IF    '${last_name}' != '${EMPTY}'     Input Text    ${INPUT_LAST_NAME}     ${last_name}
    IF    '${postal_code}' != '${EMPTY}'   Input Text    ${INPUT_POSTAL_CODE}   ${postal_code}

    Click Button    ${BTN_CONTINUE}

Validar Mensagem De Erro Checkout
    [Arguments]    ${mensagem_esperada}
    Wait Until Element Is Visible    ${ERROR_CHECKOUT}    timeout=10s
    Element Text Should Be           ${ERROR_CHECKOUT}    ${mensagem_esperada}

Validar Resumo Do Pedido E Totais
    # Espera os elementos principais da tela de resumo carregarem
    Wait Until Element Is Visible    css=.cart_item                    timeout=10s
    Wait Until Element Is Visible    css=.summary_subtotal_label       timeout=10s
    Wait Until Element Is Visible    css=.summary_tax_label            timeout=10s
    Wait Until Element Is Visible    css=.summary_total_label          timeout=10s

    # Captura os textos formatados na tela (ex: "Item total: $29.99")
    ${subtotal_text}=    Get Text    css=.summary_subtotal_label
    ${tax_text}=         Get Text    css=.summary_tax_label
    ${total_text}=       Get Text    css=.summary_total_label

    # Tratamento dos textos para converter em valores numéricos (float)
    ${subtotal}=    Evaluate    float('${subtotal_text}'.split('$')[1])
    ${tax}=         Evaluate    float('${tax_text}'.split('$')[1])
    ${total}=       Evaluate    float('${total_text}'.split('$')[1])

    # Soma e validação exata com arredondamento de 2 casas decimais
    ${soma_calculada}=    Evaluate    round(${subtotal} + ${tax}, 2)
    Should Be Equal As Numbers    ${total}    ${soma_calculada}

Finalizar Compra
    Wait Until Element Is Visible    ${BTN_FINISH}    timeout=10s
    Click Button                     ${BTN_FINISH}

Validar Tela De Sucesso
    Wait Until Page Contains         Thank you for your order!    timeout=10s
    Location Should Contain          checkout-complete.html

Validar Impedimento De Checkout Com Carrinho Vazio
    Wait Until Location Contains     cart.html    timeout=10s
    Location Should Contain          cart.html