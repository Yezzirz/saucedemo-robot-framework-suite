*** Settings ***
Documentation    Suíte de testes de carrinho e checkout (Sauce-8 até Sauce-12).
Resource         ../resources/base.robot
Resource         ../resources/pages/inventory_page.robot
Resource         ../resources/pages/checkout_page.robot
Resource         ../resources/pages/product_detail_page.robot

Test Setup       Fazer Login E2E
Test Teardown    Encerrar Sessao

*** Test Cases ***
Sauce-8: Persistencia dos itens selecionados no carrinho
    [Tags]    checkout
    Adicionar Backpack Ao Carrinho
    Acessar Carrinho
    Clicar Em Continue Shopping
    Clicar No Produto "Sauce Labs Bike Light"
    Validar Pagina De Detalhes Do Produto
    Acessar Carrinho
    Wait Until Element Is Visible    css=.inventory_item_name    timeout=10s
    Element Text Should Be           css=.inventory_item_name    Sauce Labs Backpack

Sauce-9: Validacao de campos obrigatorios no checkout
    [Tags]    checkout
    Adicionar Backpack Ao Carrinho
    Acessar Carrinho
    Clicar Em Checkout
    Preencher Formulario De Checkout    first_name=${EMPTY}    last_name=${EMPTY}    postal_code=${EMPTY}
    Validar Mensagem De Erro Checkout   Error: First Name is required
    Preencher Formulario De Checkout    first_name=Otavio      last_name=${EMPTY}    postal_code=${EMPTY}
    Validar Mensagem De Erro Checkout   Error: Last Name is required
    Preencher Formulario De Checkout    first_name=Otavio      last_name=Souza       postal_code=${EMPTY}
    Validar Mensagem De Erro Checkout   Error: Postal Code is required

Sauce-10: Calculo do valor total e resumo do pedido
    [Tags]    checkout
    Adicionar Backpack Ao Carrinho
    Acessar Carrinho
    Clicar Em Checkout
    Preencher Formulario De Checkout    first_name=Otavio    last_name=Souza    postal_code=40000000
    Validar Resumo Do Pedido E Totais

Sauce-11: Tela de confirmacao final
    [Tags]    checkout    smoke
    Adicionar Backpack Ao Carrinho
    Acessar Carrinho
    Clicar Em Checkout
    Preencher Formulario De Checkout    first_name=Otavio    last_name=Souza    postal_code=40000000
    Finalizar Compra
    Validar Tela De Sucesso

Sauce-12: Impedir finalizacao de compra com carrinho vazio
    [Tags]    checkout
    Acessar Carrinho
    Clicar Em Checkout
    Validar Impedimento De Checkout Com Carrinho Vazio