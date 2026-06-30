# Análise de Inadimplência em Operações de Crédito
Projeto de análise de dados desenvolvido a partir de uma base fictícia de contratos de empréstimo de uma fintech especializada em crédito para clientes das classes C e D.

O objetivo é identificar os principais fatores associados à inadimplência, compreender quais perfis concentram maior risco de crédito e propor recomendações que auxiliem a empresa na tomada de decisão.

Durante o projeto serão utilizadas técnicas de análise exploratória, SQL, Python (Pandas) e Power BI para transformar dados em informações estratégicas.

## Objetivo:
Desenvolver um processo analítico capaz de identificar quais características dos clientes estão associadas à inadimplência, fornecendo informações que apoiem decisões de concessão de crédito e contribuam para a redução das perdas financeiras sem comprometer excessivamente o volume de empréstimos aprovados.

## Hipóteses Analíticas

Antes da exploração dos dados, foram definidas algumas hipóteses que serão testadas durante a análise.

### Hipótese 1
Clientes com menor score de crédito apresentam maior taxa de inadimplência.

### Hipótese 2
A idade influencia a probabilidade de inadimplência.

### Hipótese 3
O gênero apresenta diferenças relevantes na taxa de inadimplência.

### Hipótese 4
Clientes com menor tempo de relacionamento apresentam maior risco.

### Hipótese 5
O canal de aquisição influencia o comportamento de pagamento.

### Pergunta principal

**Existe um perfil de cliente que concentra uma taxa de inadimplência significativamente superior à média da carteira?** 

## Metodologia

O projeto será desenvolvido seguindo as seguintes etapas:

### 1. Compreensão dos dados

- Estudo do dicionário de dados
- Entendimento das variáveis
- Identificação do problema de negócio

### 2. Importação e validação

Utilização do Python e da biblioteca Pandas para importar a base de dados e realizar verificações de qualidade, incluindo:

- valores nulos
- registros duplicados
- tipos de dados
- consistência das datas
- padronização das informações

### 3. Modelagem dos dados

Importação da base para um banco SQLite, permitindo a realização de consultas SQL e a organização dos dados para análise.

### 4. Análise exploratória

Realização de consultas SQL para identificar:

- taxa geral de inadimplência
- segmentos de maior risco
- relações entre variáveis
- padrões de comportamento dos clientes

### 5. Geração de Insights

Comparação das hipóteses iniciais com os resultados encontrados, apresentando interpretações e recomendações de negócio.

### 6. Visualização

Desenvolvimento de um dashboard no Power BI utilizando consultas SQL e views para facilitar a comunicação dos resultados.