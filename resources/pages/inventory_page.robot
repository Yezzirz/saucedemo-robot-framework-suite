*** Settings ***
Documentation    Ações e elementos do catálogo de produtos.
Library          Browser

*** Variables ***
${TITULO_PAGINA}        css=.title
${ITEM_NAME}            css=.inventory_item_name
${SELECT_SORT}          css=[data-test="product-sort-container"]
${BTN_ADD_BACKPACK}     css=[data-test="add-to-cart-sauce-labs-backpack"]
${BTN_REMOVE_BACKPACK}  css=[data-test="remove-sauce-labs-backpack"]
${BADGE_CARRINHO}       css=.shopping_cart_badge
${ICONE_CARRINHO}       css=.shopping_cart_link

*** Keywords ***
Entao a pagina de produtos deve ser exibida
    Get Text    ${TITULO_PAGINA}    ==    Products

Verificar Exibicao Dos Produtos
    Get Element States    css=.inventory_item    contains    visible
    Get Element States    css=.inventory_item_img    contains    visible
    Get Element States    css=.inventory_item_name    contains    visible
    Get Element States    css=.inventory_item_desc    contains    visible
    Get Element States    css=.inventory_item_price    contains    visible

Clicar No Produto "${nome_produto}"
    Click    text=${nome_produto}

Ordenar Produtos Por "${opcao}"
    Select Options By    ${SELECT_SORT}    label    ${opcao}

Adicionar Backpack Ao Carrinho
    Click    ${BTN_ADD_BACKPACK}

Remover Backpack Do Carrinho
    Click    ${BTN_REMOVE_BACKPACK}

Validar Botao Remove Visivel
    Get Element States    ${BTN_REMOVE_BACKPACK}    contains    visible

Validar Botao Add To Cart Visivel
    Get Element States    ${BTN_ADD_BACKPACK}    contains    visible

Validar Contador Do Carrinho
    [Arguments]    ${quantidade}
    IF    '${quantidade}' == '0'
        Get Element States    ${BADGE_CARRINHO}    contains    detached
    ELSE
        Get Text    ${BADGE_CARRINHO}    ==    ${quantidade}
    END

Acessar Carrinho
    Click    ${ICONE_CARRINHO}