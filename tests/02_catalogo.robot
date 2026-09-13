*** Settings ***
Documentation    Suíte de testes do catálogo de produtos (Sauce-5 até Sauce-7).
Resource         ../resources/base.robot
Resource         ../resources/pages/inventory_page.robot
Resource         ../resources/pages/product_detail_page.robot

Test Setup       Fazer Login E2E
Test Teardown    Encerrar Sessao

*** Test Cases ***
Sauce-5: Visualizacao da lista de produtos e detalhes do item
    [Tags]    catalogo
    Verificar Exibicao Dos Produtos
    Clicar No Produto "Sauce Labs Backpack"
    Validar Pagina De Detalhes Do Produto

Sauce-6: Ordenacao de produtos
    [Tags]    catalogo
    Ordenar Produtos Por "Name (Z to A)"
    Ordenar Produtos Por "Price (low to high)"
    Ordenar Produtos Por "Price (high to low)"
    Ordenar Produtos Por "Name (A to Z)"

Sauce-7: Adicao e remocao de produtos direto da vitrine
    [Tags]    catalogo
    Adicionar Backpack Ao Carrinho
    Validar Botao Remove Visivel
    Validar Contador Do Carrinho    1
    Remover Backpack Do Carrinho
    Validar Botao Add To Cart Visivel
    Validar Contador Do Carrinho    0