*** Settings ***
Documentation    Ações e elementos da página de detalhes do produto.
Library          SeleniumLibrary

*** Keywords ***
Validar Pagina De Detalhes Do Produto
    Wait Until Location Contains     inventory-item.html    timeout=10s
    Wait Until Element Is Visible    css=.inventory_details_name    timeout=10s
    Wait Until Element Is Visible    css=[data-test="add-to-cart"]    timeout=10s