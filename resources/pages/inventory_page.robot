*** Settings ***
Documentation    Ações e elementos do catálogo de produtos.
Library          SeleniumLibrary

*** Variables ***
${TITULO_PAGINA}        css=.title
${SELECT_SORT}          css=[data-test="product-sort-container"]
${BTN_ADD_BACKPACK}     css=[data-test="add-to-cart-sauce-labs-backpack"]
${BTN_REMOVE_BACKPACK}  css=[data-test="remove-sauce-labs-backpack"]
${BADGE_CARRINHO}       css=.shopping_cart_badge
${ICONE_CARRINHO}       css=.shopping_cart_link

*** Keywords ***
Entao a pagina de produtos deve ser exibida
    Wait Until Element Is Visible    ${TITULO_PAGINA}    timeout=10s
    Element Text Should Be           ${TITULO_PAGINA}    Products

Verificar Exibicao Dos Produtos
    Wait Until Element Is Visible    css=.inventory_item    timeout=10s
    Page Should Contain Element      css=.inventory_item_img
    Page Should Contain Element      css=.inventory_item_name
    Page Should Contain Element      css=.inventory_item_price

Clicar No Produto "${nome_produto}"
    Wait Until Element Is Visible    xpath=//div[text()="${nome_produto}"]    timeout=10s
    Click Element                    xpath=//div[text()="${nome_produto}"]

Ordenar Produtos Por "${opcao}"
    Wait Until Element Is Visible    ${SELECT_SORT}    timeout=10s
    Select From List By Label        ${SELECT_SORT}    ${opcao}

Adicionar Backpack Ao Carrinho
    Wait Until Element Is Visible    ${BTN_ADD_BACKPACK}    timeout=10s
    Click Button                     ${BTN_ADD_BACKPACK}

Remover Backpack Do Carrinho
    Wait Until Element Is Visible    ${BTN_REMOVE_BACKPACK}    timeout=10s
    Click Button                     ${BTN_REMOVE_BACKPACK}

Validar Botao Remove Visivel
    Wait Until Element Is Visible    ${BTN_REMOVE_BACKPACK}    timeout=10s

Validar Botao Add To Cart Visivel
    Wait Until Element Is Visible    ${BTN_ADD_BACKPACK}       timeout=10s

Validar Contador Do Carrinho
    [Arguments]    ${quantidade}
    IF    '${quantidade}' == '0'
        Element Should Not Be Visible    ${BADGE_CARRINHO}
    ELSE
        Wait Until Element Is Visible    ${BADGE_CARRINHO}    timeout=10s
        Element Text Should Be           ${BADGE_CARRINHO}    ${quantidade}
    END

Acessar Carrinho
    Wait Until Element Is Visible    ${ICONE_CARRINHO}    timeout=10s
    Click Element                    ${ICONE_CARRINHO}