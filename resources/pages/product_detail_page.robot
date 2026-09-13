*** Settings ***
Documentation    Ações e elementos da página de detalhes do produto.
Library          Browser

*** Keywords ***
Validar Pagina De Detalhes Do Produto
    Get Url    contains    inventory-item.html
    Get Element States    css=.inventory_details_name    contains    visible
    Get Element States    css=[data-test="add-to-cart"]    contains    visible