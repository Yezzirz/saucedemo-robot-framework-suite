*** Settings ***
Documentation    Ações e elementos do fluxo de carrinho e checkout.
Library          Browser

*** Variables ***
${BTN_CHECKOUT}           css=[data-test="checkout"]
${BTN_CONTINUE_SHOPPING} css=[data-test="continue-shopping"]
${BTN_CONTINUE}           css=[data-test="continue"]
${BTN_FINISH}             css=[data-test="finish"]
${INPUT_FIRST_NAME}       css=#first-name
${INPUT_LAST_NAME}        css=#last-name
${INPUT_POSTAL_CODE}      css=#postal-code
${ERROR_CHECKOUT}         css=[data-test="error"]

*** Keywords ***
Clicar Em Checkout
    Click    ${BTN_CHECKOUT}

Clicar Em Continue Shopping
    Click    ${BTN_CONTINUE_SHOPPING}

Preencher Formulario De Checkout
    [Arguments]    ${first_name}=    ${last_name}=    ${postal_code}=
    IF    '${first_name}' != '${EMPTY}'    Type Text    ${INPUT_FIRST_NAME}    ${first_name}
    IF    '${last_name}' != '${EMPTY}'     Type Text    ${INPUT_LAST_NAME}     ${last_name}
    IF    '${postal_code}' != '${EMPTY}'   Type Text    ${INPUT_POSTAL_CODE}   ${postal_code}
    Click    ${BTN_CONTINUE}

Validar Mensagem De Erro Checkout
    [Arguments]    ${mensagem_esperada}
    Get Text    ${ERROR_CHECKOUT}    ==    ${mensagem_esperada}

Validar Resumo Do Pedido E Totais
    Get Element States    css=.cart_item    contains    visible
    
    # Validação dos cálculos: Subtotal + Imposto = Total
    ${subtotal_text}=    Get Text    css=.summary_subtotal_label
    ${tax_text}=         Get Text    css=.summary_tax_label
    ${total_text}=       Get Text    css=.summary_total_label

    # Extrai os valores numéricos dos textos ex: "Item total: $29.99" -> "29.99"
    ${subtotal}=    Evaluate    float('${subtotal_text}'.split('$')[1])
    ${tax}=         Evaluate    float('${tax_text}'.split('$')[1])
    ${total}=       Evaluate    float('${total_text}'.split('$')[1])

    ${soma_calculada}=    Evaluate    round(${subtotal} + ${tax}, 2)
    Should Be Equal As Numbers    ${total}    ${soma_calculada}

Finalizar Compra
    Click    ${BTN_FINISH}

Validar Tela De Sucesso
    Get Url    contains    checkout-complete.html
    Get Text    css=.complete-header    ==    Thank you for your order!

Validar Impedimento De Checkout Com Carrinho Vazio
    # No SauceDemo real, o sistema permite avançar com carrinho vazio.
    # Esta keyword valida o comportamento esperado de bloqueio ou URL mantida.
    Get Url    contains    cart.html