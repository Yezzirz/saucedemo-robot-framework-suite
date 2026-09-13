*** Settings ***
Documentation    Massa de dados e credenciais do SauceDemo.

*** Variables ***
# Credenciais
${PASSWORD_ALL_USERS}         secret_sauce

# Usuários Válidos e de Teste
${USER_STANDARD}              standard_user
${USER_LOCKED_OUT}            locked_out_user
${USER_PROBLEM}               problem_user
${USER_GLITCH}                performance_glitch_user
${USER_ERROR}                 error_user
${USER_VISUAL}                visual_user

# Credenciais Inválidas (Para testes de falha)
${USER_INVALID}               invalid_user
${PASSWORD_INVALID}           invalid_password