# 🎭 SauceDemo - Automação E2E com Robot Framework & CI/CD

Este repositório contém uma suíte automatizada de testes End-to-End (E2E) para a aplicação web [SauceDemo](https://www.saucedemo.com/), desenvolvida com **Robot Framework** e **SeleniumLibrary**, aplicando a arquitetura **Page Object Model (POM)** e integrada a uma pipeline contínua no **GitHub Actions**.

---

## 🛠️ Tecnologias Utilizadas

- **Linguagem/Framework:** Python 3.11 & Robot Framework (v7.0)
- **Biblioteca Web:** SeleniumLibrary
- **Arquitetura:** Page Object Model (POM)
- **CI/CD:** GitHub Actions (Runner Ubuntu + Chrome Headless)
- **Relatórios:** Output nativo Robot, xUnit/JUnit XML e GitHub Step Summary via scripts em Python

---

## 🌟 Boas Práticas de QA & DevOps Aplicadas

Neste projeto foram implementadas padrões de arquitetura e engenharia de software voltados para alta manutenibilidade, resiliência e visibilidade de testes:

- **Page Object Model (POM):** Separação clara entre a lógica dos testes (`tests/`), os seletores/ações de tela (`resources/pages/`) e os dados de teste (`variables/data.robot`), evitando duplicação de código e facilitando manutenções futuras.
- **Isolamento de Dados & Configurações:** Centralização de URLs, credenciais e seletores em arquivos de recursos e variáveis reutilizáveis.
- **Nomenclatura Padrão & Organização:** Suítes numeradas sequencialmente (`01_login`, `02_catalogo`, `03_checkout`) garantindo ordem determinística de execução e descoberta automática.
- **Cross-Format Reporting (xUnit/JUnit):** Exportação simultânea do relatório nativo do Robot e do padrão `xUnit` (`-x xunit.xml`), garantindo compatibilidade universal com ferramentas de CI/CD (GitHub Actions, Azure DevOps, Jenkins).
- **Tratamento Transparente de Bugs Conhecidos (*Known Issues*):** Mapeamento explícito de falhas conhecidas (`Sauce-12`) através de tags e `continue-on-error: true`, evitando a quebra desnecessária da esteira de deploy sem ocultar a falha.
- **Self-Documenting Pipeline (DevOps/DX):** Uso de scripts Python embutidos no workflow para parsear o `output.xml` em tempo real, gerando métricas agregadas e relatórios amigáveis em Markdown no **Job Summary** para toda a equipe.
- **Gestão de Artefatos:** Salvamento e exportação dos relatórios HTML completos (`log.html` e `report.html`) como artefatos baixáveis (`robot-results`) a cada execução da CI.

---

## 📁 Estrutura do Projeto

.github/
└── workflows/
    └── robot-ci.yml        # Pipeline de CI/CD automatizada
resources/
└── pages/                  # Page Objects (elementos e palavras-chave por tela)
    ├── login_page.robot
    ├── inventory_page.robot
    ├── product_detail_page.robot
    └── checkout_page.robot
tests/
├── 01_login.robot          # Suíte de autenticação
├── 02_catalogo.robot       # Suíte de navegação e produtos
└── 03_checkout.robot       # Suíte de fluxo de compra
variables/
└── data.robot              # Variáveis globais e dados de teste
requirements.txt            # Dependências Python do projeto
README.md                   # Documentação do projeto

---

## 🚀 Como Executar Localmente

### Pré-requisitos
- Python 3.10+ instalado
- Google Chrome instalado

### Passo a passo
1. Clone o repositório:
   git clone https://github.com/SeuUsuario/saucedemo-robot-framework-suite.git
   cd saucedemo-robot-framework-suite

2. Instale as dependências:
   pip install -r requirements.txt

3. Execute toda a suíte de testes:
   robot -d ./results tests/

4. Para rodar em modo visível (Headful):
   robot --variable BROWSER:chrome -d ./results tests/

5. Visualize os relatórios em `./results/log.html` e `./results/report.html`.

---

## ⚙️ Pipeline de CI/CD (GitHub Actions)

A pipeline automatizada (`.github/workflows/robot-ci.yml`) é disparada a cada `push` ou `pull_request` nas branches `main` e `master`.

### Destaques da Pipeline:
1. **Execução em Ambiente Headless:** Roda a suíte completa com `google-chrome-stable` no runner Ubuntu.
2. **Exportação Simultânea:** Gera o `output.xml` nativo e utiliza a flag `-x xunit.xml` para integração com relatórios padrão de mercado.
3. **Métricas Dinâmicas (Python Script):** Um script em Python embarcado no workflow analisa o `output.xml` em tempo de execução, extrai as métricas exatas de testes aprovados/reprovados e disponibiliza os valores via `$GITHUB_ENV`.
4. **Mapeamento Automático de Falhas & Known Issues:** Um parser em Python lê os testes que falharam, verifica a presença de tags de bugs mapeados (`known-issue:Sauce-12`) e gera uma tabela legível em Markdown no resumo do Job.
5. **Job Summary Visual:** Renderiza a `test-summary/action@v2` junto ao painel customizado no GitHub Actions, exibindo ambiente, métricas agregadas e tabela de erros.
6. **Resiliência Controlada (`continue-on-error`):** Permite a execução completa da pipeline sem bloquear o fluxo por conta de falhas já conhecidas da aplicação, registrando os artefatos oficiais (`robot-results`) para download.

---

## 🐛 Bug Mapeado (Known Issue)

| ID | Suíte | Comportamento Esperado | Comportamento Atual | Status na CI |
| :--- | :--- | :--- | :--- | :--- |
| **Sauce-12** | `03_checkout.robot` | Bloquear o checkout e permanecer na página `cart.html` caso o carrinho esteja vazio. | A aplicação permite prosseguir para a etapa `checkout-step-one.html` mesmo sem itens. | Mapeado (`continue-on-error: true`) |