# Hospital Analytics Dashboard — Documentação Técnica e Guia do Usuário

**Versão:** 1.0  
**Data:** Maio de 2026  
**Autor:** Michele Oliveira  
**Ferramenta:** Power BI Desktop  
**Dataset:** Kaggle — Hospital Management Dataset  
**Repositório:** [GitHub](https://github.com/micheleoliveiracod/Hospital_data_case)

---

## Sumário

1. [Contexto e Problema de Negócio](#1-contexto-e-problema-de-negócio)
2. [Stakeholders](#2-stakeholders)
3. [Objetivos do Dashboard](#3-objetivos-do-dashboard)
4. [Fonte de Dados e ETL](#4-fonte-de-dados-e-etl)
5. [Modelagem de Dados](#5-modelagem-de-dados)
6. [Estrutura do Dashboard](#6-estrutura-do-dashboard)
7. [Guia do Usuário](#7-guia-do-usuário)
8. [Memorial de Cálculo (DAX)](#8-memorial-de-cálculo-dax)
9. [Insights e Recomendações](#9-insights-e-recomendações)
10. [Limitações e Premissas](#10-limitações-e-premissas)
11. [Como Executar o Projeto](#11-como-executar-o-projeto)
12. [Glossário](#12-glossário)

---

## 1. Contexto e Problema de Negócio

### 1.1 Cenário

O hospital opera com três unidades — **Central Hospital**, **Westside Clinic** e **Eastside Clinic** — atendendo pacientes em diversas especialidades médicas (Pediatria, Dermatologia e Oncologia). O modelo de negócio envolve agendamento de consultas, realização de procedimentos clínicos e cobrança por meio de diferentes métodos de pagamento (plano de saúde, cartão de crédito e dinheiro).

A gestão identificou dificuldades em responder perguntas críticas de forma ágil:

- O hospital está gerando lucro ou prejuízo?
- Quais procedimentos são mais rentáveis?
- Por que tantos pagamentos estão pendentes ou falhando?
- Qual é a taxa de cancelamento e no-show de consultas?
- Existem gargalos operacionais no agendamento?

Sem visibilidade centralizada sobre esses indicadores, decisões estratégicas e operacionais eram tomadas com base em planilhas isoladas, sem integração entre as áreas financeira e clínica.

### 1.2 Problema Central

> **O hospital não possui um mecanismo de monitoramento integrado que conecte desempenho financeiro, eficiência de cobrança e eficiência operacional de agendamentos em uma única visão analítica.**

Isso resulta em:

- Incapacidade de identificar procedimentos com margem negativa
- Acúmulo de inadimplência sem rastreamento por método de pagamento
- Alta taxa de consultas canceladas e no-show sem análise de causa
- Ausência de sazonalidade mapeada para planejamento de capacidade

---

## 2. Stakeholders

| Stakeholder | Perfil | Interesse Principal | Visão Relevante |
|---|---|---|---|
| **Diretoria Executiva** | C-Level / Gestão Estratégica | Rentabilidade, valuation e sustentabilidade do negócio | Estratégica |
| **Gerência Financeira** | Controller / CFO | Receita, inadimplência, métodos de pagamento, margem | Estratégica + Tática |
| **Gerência de Operações** | COO / Coordenador Clínico | Taxa de cancelamento, no-show, tempo de espera | Operacional |
| **Equipe de Faturamento** | Analistas de Cobrança | Status de pagamentos, falhas por método, pendências | Tática |
| **Médicos e Coordenadores Clínicos** | Especialistas | Volume de atendimentos, tipos de procedimento | Operacional |
| **Analistas de Dados / BI** | Equipe Técnica | Manutenção do modelo, atualização de dados, DAX | Técnica |

---

## 3. Objetivos do Dashboard

### Objetivo Geral
Fornecer uma plataforma analítica integrada que permita monitorar a saúde financeira e operacional do hospital, suportando decisões baseadas em dados nas três camadas de gestão: estratégica, tática e operacional.

### Objetivos Específicos

| # | Objetivo | KPI Principal |
|---|---|---|
| 1 | Avaliar a performance financeira global | Receita Total, Margem Bruta, EBITDA |
| 2 | Identificar procedimentos com problemas de precificação | Receita e Custo por Tipo de Tratamento |
| 3 | Detectar padrões de inadimplência | % Pagamentos Falhos e Pendentes por Método |
| 4 | Monitorar eficiência operacional de agendamentos | Taxa de Cancelamento, No-show, Tempo de Espera |
| 5 | Identificar sazonalidade na demanda | Volume de Consultas por Mês/Ano |


---

## 4. Fonte de Dados e ETL

### 4.1 Origem dos Dados

Os dados utilizados neste projeto são provenientes de um dataset público disponível no Kaggle:

> **Hospital Management Dataset**  
> Autor: Kanak Baghel  
> Link: https://www.kaggle.com/datasets/kanakbaghel/hospital-management-dataset  
> Licença: Uso educacional e portfólio

O dataset simula um ambiente hospitalar real com 200 registros por tabela, cobrindo o período de **janeiro a dezembro de 2023**.

### 4.2 Tabelas de Origem

| Arquivo | Registros | Descrição |
|---|---|---|
| `appointments.csv` | 200 | Agendamentos de consultas |
| `billing.csv` | 200 | Cobranças e status de pagamento |
| `doctors.csv` | 10 | Cadastro de médicos |
| `patients.csv` | 50 | Cadastro de pacientes |
| `treatments.csv` | 200 | Procedimentos realizados |

### 4.3 Dicionário de Dados

#### Tabela: appointments (Agendamentos)

| Campo | Tipo | Descrição | Exemplo |
|---|---|---|---|
| `appointment_id` | TEXT (PK) | Identificador único do agendamento | A001 |
| `patient_id` | TEXT (FK) | Referência ao paciente | P034 |
| `doctor_id` | TEXT (FK) | Referência ao médico | D009 |
| `appointment_date` | DATE | Data do agendamento | 2023-08-09 |
| `appointment_time` | TIME | Horário do agendamento | 15:15:00 |
| `reason_for_visit` | TEXT | Motivo da visita | Therapy, Consultation, Emergency, Follow-up, Checkup |
| `status` | TEXT | Status do agendamento | Scheduled, Completed, Cancelled, No-show |

#### Tabela: billing (Faturamento)

| Campo | Tipo | Descrição | Exemplo |
|---|---|---|---|
| `bill_id` | TEXT (PK) | Identificador único da cobrança | B001 |
| `patient_id` | TEXT (FK) | Referência ao paciente | P034 |
| `treatment_id` | TEXT (FK) | Referência ao tratamento | T001 |
| `bill_date` | DATE | Data da cobrança | 2023-08-09 |
| `amount` | DECIMAL | Valor cobrado (USD) | 3941.97 |
| `payment_method` | TEXT | Método de pagamento | Insurance, Credit Card, Cash |
| `payment_status` | TEXT | Status do pagamento | Paid, Pending, Failed |

#### Tabela: doctors (Médicos)

| Campo | Tipo | Descrição | Exemplo |
|---|---|---|---|
| `doctor_id` | TEXT (PK) | Identificador único do médico | D001 |
| `first_name` | TEXT | Primeiro nome | David |
| `last_name` | TEXT | Sobrenome | Taylor |
| `specialization` | TEXT | Especialidade médica | Dermatology, Pediatrics, Oncology |
| `phone_number` | TEXT | Telefone de contato | 8322010158 |
| `years_experience` | INT | Anos de experiência | 17 |
| `hospital_branch` | TEXT | Unidade hospitalar | Westside Clinic, Eastside Clinic, Central Hospital |
| `email` | TEXT | E-mail profissional | dr.david.taylor@hospital.com |

#### Tabela: patients (Pacientes)

| Campo | Tipo | Descrição | Exemplo |
|---|---|---|---|
| `patient_id` | TEXT (PK) | Identificador único do paciente | P001 |
| `first_name` | TEXT | Primeiro nome | David |
| `last_name` | TEXT | Sobrenome | Williams |
| `gender` | TEXT | Gênero | M, F |
| `date_of_birth` | DATE | Data de nascimento | 1955-06-04 |
| `contact_number` | TEXT | Telefone de contato | 6939585183 |
| `address` | TEXT | Endereço | 789 Pine Rd |
| `registration_date` | DATE | Data de cadastro no hospital | 2022-06-23 |
| `insurance_provider` | TEXT | Operadora de plano de saúde | WellnessCorp, PulseSecure, HealthIndia, MedCare Plus |
| `insurance_number` | TEXT | Número da apólice | INS840674 |
| `email` | TEXT | E-mail do paciente | david.williams@mail.com |

#### Tabela: treatments (Tratamentos)

| Campo | Tipo | Descrição | Exemplo |
|---|---|---|---|
| `treatment_id` | TEXT (PK) | Identificador único do tratamento | T001 |
| `appointment_id` | TEXT (FK) | Referência ao agendamento | A001 |
| `treatment_type` | TEXT | Tipo de procedimento | Chemotherapy, MRI, ECG, X-Ray, Physiotherapy |
| `description` | TEXT | Nível do protocolo | Basic screening, Standard procedure, Advanced protocol |
| `cost` | DECIMAL | Custo do procedimento (USD) | 3941.97 |
| `treatment_date` | DATE | Data de realização do tratamento | 2023-08-09 |

### 4.4 Processo de ETL (Extract, Transform, Load)

#### Etapa 1 — Extração (Extract)

Os cinco arquivos CSV foram extraídos do Kaggle e armazenados localmente na pasta `/data`. Um join entre as tabelas `appointments` e `treatments` foi realizado previamente em R, gerando o arquivo `unified_table_modified.csv` na pasta `/data/Join`.

**Script R utilizado (`script_join.R`):**

```r
# Carregamento das bibliotecas
library(DBI); library(RSQLite); library(readr); library(dplyr)

# Leitura dos CSVs
appointments <- read_csv("appointments.csv")
treatments   <- read_csv("treatments.csv")

# Join completo entre appointments e treatments
JOIN <- full_join(appointments, treatments, by = "appointment_id")
write_csv(JOIN, "tabela_unificada.csv")
```

O script também demonstra a equivalência em SQL:

```sql
SELECT *
FROM treatments
FULL JOIN appointments ON treatments.appointment_id = appointments.appointment_id
```

#### Etapa 2 — Transformação (Transform) no Power Query

Após a importação dos CSVs no Power BI, as seguintes transformações foram aplicadas via Power Query (M Language):

| Transformação | Tabela | Descrição |
|---|---|---|
| Definição de tipos de dados | Todas | Datas como `Date`, valores como `Decimal Number`, IDs como `Text` |
| Remoção de colunas desnecessárias | Patients, Doctors | Remoção de campos de contato não utilizados nas análises |
| Criação de coluna de nome completo | Patients, Doctors | Concatenação de `first_name` + `last_name` |
| Padronização de valores categóricos | Appointments, Billing | Verificação de consistência nos campos `status` e `payment_status` |
| Relacionamento entre tabelas | Todas | Definição das chaves primárias e estrangeiras no modelo |

#### Etapa 3 — Carga (Load)

As tabelas foram carregadas no modelo do Power BI seguindo o esquema estrela (Star Schema), com a tabela `Appointments` como fato central e as demais como dimensões.


---

## 5. Modelagem de Dados

### 5.1 Diagrama do Modelo (Star Schema)

```
                    ┌─────────────┐
                    │   PATIENTS  │
                    │  (Dimensão) │
                    └──────┬──────┘
                           │ patient_id
                           │
┌─────────────┐    ┌───────▼──────────┐    ┌─────────────┐
│   DOCTORS   │    │   APPOINTMENTS   │    │  TREATMENTS │
│  (Dimensão) ├────►    (Fato)        ◄────┤  (Dimensão) │
└─────────────┘    └───────┬──────────┘    └─────────────┘
    doctor_id              │ appointment_id     treatment_id
                           │
                    ┌──────▼──────┐
                    │   BILLING   │
                    │  (Dimensão) │
                    └─────────────┘
                       patient_id
                      treatment_id
```

### 5.2 Tabela Fato

**Appointments** é a tabela central do modelo. Cada linha representa um evento de agendamento, conectando paciente, médico e, indiretamente via `treatment_id`, o procedimento realizado e a cobrança correspondente.

| Atributo | Valor |
|---|---|
| Granularidade | 1 linha = 1 agendamento |
| Registros | 200 |
| Chave Primária | `appointment_id` |
| Chaves Estrangeiras | `patient_id`, `doctor_id` |

### 5.3 Tabelas Dimensão

| Tabela | Papel | Chave PK | Relacionamento com Fato |
|---|---|---|---|
| **Patients** | Dimensão de Pacientes | `patient_id` | Appointments.patient_id → Patients.patient_id |
| **Doctors** | Dimensão de Médicos | `doctor_id` | Appointments.doctor_id → Doctors.doctor_id |
| **Treatments** | Dimensão de Procedimentos | `treatment_id` | Treatments.appointment_id → Appointments.appointment_id |
| **Billing** | Dimensão de Faturamento | `bill_id` | Billing.treatment_id → Treatments.treatment_id |

### 5.4 Cardinalidade dos Relacionamentos

| Relacionamento | Cardinalidade | Direção do Filtro |
|---|---|---|
| Appointments → Patients | Muitos para Um (N:1) | Único (Patients → Appointments) |
| Appointments → Doctors | Muitos para Um (N:1) | Único (Doctors → Appointments) |
| Treatments → Appointments | Um para Um (1:1) | Único |
| Billing → Treatments | Um para Um (1:1) | Único |

### 5.5 Observações sobre o Modelo

- A relação entre `Billing` e `Appointments` é indireta, passando por `Treatments`. Isso significa que para cruzar dados financeiros com dados de agendamento, o caminho percorre: `Billing → Treatments → Appointments`.
- O campo `amount` em `Billing` e o campo `cost` em `Treatments` possuem os mesmos valores no dataset, indicando que o custo do tratamento é diretamente repassado ao paciente como valor de cobrança — sem markup explícito no dataset.
- Não existe uma tabela de calendário (Date Table) explícita no dataset. Recomenda-se criar uma `DimCalendario` no Power BI para análises temporais mais robustas.

---

## 6. Estrutura do Dashboard

O dashboard é composto por **três visões analíticas**, cada uma direcionada a um perfil de usuário e nível de decisão.

### 6.1 Visão Estratégica — Performance Financeira

**Público-alvo:** Diretoria, CFO, Gestão Executiva  
**Objetivo:** Avaliar a saúde financeira do hospital e identificar problemas estruturais de rentabilidade.

#### Indicadores (KPIs)

| Indicador | Descrição | Fonte |
|---|---|---|
| **Receita Total** | Soma de todos os valores cobrados (`billing.amount`) | Tabela Billing |
| **Custo Total** | Soma de todos os custos de tratamento (`treatments.cost`) | Tabela Treatments |
| **Margem Bruta ($)** | Receita Total − Custo Total | Calculado (DAX) |
| **Margem Bruta (%)** | (Margem Bruta / Receita Total) × 100 | Calculado (DAX) |
| **Ticket Médio** | Receita Total / Número de Cobranças | Calculado (DAX) |
| **Despesas Operacionais** | 60% da Receita Total (premissa assumida) | Calculado (DAX) |
| **EBITDA ($)** | Margem Bruta − Despesas Operacionais | Calculado (DAX) |
| **Margem EBITDA (%)** | (EBITDA / Receita Total) × 100 | Calculado (DAX) |
| **Valuation ($)** | EBITDA × Múltiplo de Mercado (premissa) | Calculado (DAX) |

#### Visualizações

| Visual | Tipo | Descrição |
|---|---|---|
| Cards de KPI | Card | Receita, Custo, Margem, EBITDA, Valuation |
| Receita e Custo por Procedimento | Gráfico de Barras Agrupadas | Comparação por tipo de tratamento |
| Margem por Procedimento | Gráfico de Barras | Identificação de procedimentos deficitários |
| Status de Pagamentos | Gráfico de Rosca / Pizza | % Paid, Pending, Failed |
| Série Temporal de Pagamentos | Gráfico de Linha | Evolução mensal de receita e cobranças |

---

### 6.2 Visão Tática — Análise de Pagamentos

**Público-alvo:** Gerência Financeira, Equipe de Faturamento  
**Objetivo:** Identificar padrões de falha e inadimplência por método de pagamento e tipo de procedimento.

#### Indicadores (KPIs)

| Indicador | Descrição |
|---|---|
| **Pagamentos Realizados ($)** | Soma dos valores com `payment_status = 'Paid'` |
| **Pagamentos Pendentes ($)** | Soma dos valores com `payment_status = 'Pending'` |
| **Pagamentos Falhos ($)** | Soma dos valores com `payment_status = 'Failed'` |

#### Visualizações

| Visual | Tipo | Descrição |
|---|---|---|
| Cards de Status | Card | Valores totais por status de pagamento |
| Pagamentos por Método | Gráfico de Barras Empilhadas | Paid/Pending/Failed por Insurance, Credit Card, Cash |
| Pagamentos por Tratamento | Gráfico de Barras Empilhadas | Paid/Pending/Failed por tipo de procedimento |
| Tabela Detalhada | Tabela | Drill-down por paciente, método e status |

#### Perguntas que esta visão responde

- Por que o método **Insurance** concentra alto volume de pagamentos pendentes?
- Por que o método **Cash** apresenta alta taxa de falhas?
- Quais procedimentos têm maior índice de inadimplência?
- Existe correlação entre tipo de tratamento e método de pagamento problemático?

---

### 6.3 Visão Operacional — Gestão de Agendamentos

**Público-alvo:** Coordenadores Clínicos, Gerência de Operações  
**Objetivo:** Monitorar a eficiência operacional dos agendamentos e identificar gargalos.

#### Indicadores (KPIs)

| Indicador | Descrição |
|---|---|
| **Dias de Espera** | Diferença entre `appointment_date` e `treatment_date` |
| **Consultas Concluídas** | Contagem de `status = 'Completed'` |
| **Consultas Canceladas** | Contagem de `status = 'Cancelled'` |
| **No-show** | Contagem de `status = 'No-show'` |
| **Consultas Agendadas** | Contagem de `status = 'Scheduled'` |

#### Visualizações

| Visual | Tipo | Descrição |
|---|---|---|
| Cards de Status | Card | Totais por status de agendamento |
| Volume de Consultas ao Longo do Tempo | Gráfico de Linha | Evolução mensal do volume |
| Consultas por Mês e Ano | Gráfico de Barras | Sazonalidade e comparativo anual |
| Consultas por Status | Gráfico de Barras | Distribuição por status |
| Tempo de Espera por Tratamento | Gráfico de Barras | Média de dias de espera por tipo de procedimento |

#### Perguntas que esta visão responde

- Quais meses concentram maior volume de agendamentos?
- Qual é a taxa de cancelamento e no-show?
- Quais procedimentos têm maior tempo de espera?
- Existe sazonalidade que justifique planejamento de capacidade?


---

## 7. Guia do Usuário

### 7.1 Requisitos para Acesso

| Requisito | Detalhe |
|---|---|
| Software | Power BI Desktop (versão mais recente recomendada) |
| Arquivo | `Hospital_data_case.pbix` (pasta `/pbix`) |
| Dados | CSVs na pasta `/data` (necessários para atualização) |
| Sistema Operacional | Windows 10 ou superior |

### 7.2 Como Abrir o Dashboard

1. Faça o download do repositório ou clone via Git:
   ```bash
   git clone https://github.com/micheleoliveiracod/Hospital_data_case.git
   ```
2. Abra o Power BI Desktop.
3. Vá em **Arquivo → Abrir** e selecione o arquivo `pbix/Hospital_data_case.pbix`.
4. Caso seja solicitado, atualize o caminho das fontes de dados apontando para a pasta `/data` do repositório.
5. Clique em **Atualizar** para carregar os dados mais recentes.

### 7.3 Navegação entre as Visões

O dashboard possui **três páginas** acessíveis pelo painel de navegação lateral ou pelas abas na parte inferior do Power BI:

| Aba | Nome | Perfil de Usuário |
|---|---|---|
| 1 | Visão Estratégica | Diretoria / CFO |
| 2 | Visão Tática | Financeiro / Faturamento |
| 3 | Visão Operacional | Operações / Clínico |

### 7.4 Como Usar os Filtros (Slicers)

Cada visão possui filtros interativos que permitem segmentar os dados. Ao selecionar um valor em qualquer filtro, **todos os visuais da página são atualizados automaticamente**.

#### Filtros Disponíveis

| Filtro | Localização | Valores Possíveis |
|---|---|---|
| **Período (Mês/Ano)** | Todas as visões | Jan–Dez 2023 |
| **Tipo de Tratamento** | Estratégica e Tática | Chemotherapy, MRI, ECG, X-Ray, Physiotherapy |
| **Método de Pagamento** | Tática | Insurance, Credit Card, Cash |
| **Status do Pagamento** | Tática | Paid, Pending, Failed |
| **Status do Agendamento** | Operacional | Completed, Cancelled, No-show, Scheduled |
| **Unidade Hospitalar** | Todas as visões | Central Hospital, Westside Clinic, Eastside Clinic |
| **Especialidade Médica** | Operacional | Dermatology, Pediatrics, Oncology |

### 7.5 Como Interpretar os KPIs

#### Visão Estratégica

| KPI | Interpretação | Sinal de Alerta |
|---|---|---|
| **Receita Total** | Total faturado no período selecionado | Queda mês a mês |
| **Margem Bruta (%)** | Se negativa, o custo dos procedimentos supera a receita | Valor negativo |
| **EBITDA** | Resultado operacional estimado após despesas | Valor negativo indica insustentabilidade |
| **% Pagamentos Paid** | Proporção de cobranças efetivamente recebidas | Abaixo de 50% é crítico |

#### Visão Tática

| KPI | Interpretação | Sinal de Alerta |
|---|---|---|
| **Pagamentos Falhos ($)** | Valor que o hospital perdeu por falha no processo de cobrança | Crescimento contínuo |
| **Pagamentos Pendentes ($)** | Valor em aberto, ainda pode ser recuperado | Alto volume em Insurance |
| **Falhas por Método** | Identifica qual canal de pagamento é mais problemático | Cash com alta falha |

#### Visão Operacional

| KPI | Interpretação | Sinal de Alerta |
|---|---|---|
| **Taxa de No-show** | % de pacientes que não compareceram sem aviso | Acima de 20% |
| **Taxa de Cancelamento** | % de consultas canceladas | Acima de 25% |
| **Dias de Espera** | Tempo médio entre agendamento e realização do tratamento | Acima de 30 dias |

### 7.6 Funcionalidades de Drill-down

Nos gráficos de série temporal e barras, é possível navegar entre níveis de granularidade:

- **Clique duplo** em uma barra ou ponto: desce para o próximo nível (ex.: Ano → Mês → Dia)
- **Botão de hierarquia** (seta para baixo no canto superior do visual): expande todos os níveis
- **Ctrl + Clique** em um elemento: aplica filtro cruzado nos demais visuais da página

### 7.7 Exportação de Dados

Para exportar os dados de qualquer visual:
1. Clique com o botão direito sobre o visual desejado.
2. Selecione **Exportar dados**.
3. Escolha o formato: `.xlsx` (Excel) ou `.csv`.


---

## 8. Memorial de Cálculo (DAX)

Esta seção documenta todas as medidas DAX criadas no modelo, com sua fórmula, descrição e contexto de uso.

### 8.1 Medidas Financeiras — Visão Estratégica

---

#### Receita Total
```dax
Receita Total = SUM(billing[amount])
```
**Descrição:** Soma de todos os valores cobrados na tabela de faturamento, independentemente do status de pagamento. Representa o total faturado (não necessariamente recebido).  
**Tabela de origem:** `billing`  
**Campo:** `amount`

---

#### Custo Total
```dax
Custo Total = SUM(treatments[cost])
```
**Descrição:** Soma de todos os custos de procedimentos realizados. No dataset, o custo do tratamento é igual ao valor cobrado ao paciente.  
**Tabela de origem:** `treatments`  
**Campo:** `cost`

---

#### Margem Bruta ($)
```dax
Margem Bruta = [Receita Total] - [Custo Total]
```
**Descrição:** Diferença entre receita faturada e custo dos procedimentos. Indica se o hospital está cobrando acima ou abaixo do custo operacional clínico.  
**Nota:** Como `billing.amount` = `treatments.cost` no dataset, esta medida tende a zero, evidenciando ausência de markup na precificação.

---

#### Margem Bruta (%)
```dax
Margem Bruta % = 
DIVIDE([Margem Bruta], [Receita Total], 0)
```
**Descrição:** Percentual da margem bruta sobre a receita total. Usa `DIVIDE` para evitar erro de divisão por zero.

---

#### Ticket Médio
```dax
Ticket Médio = 
DIVIDE([Receita Total], COUNTROWS(billing), 0)
```
**Descrição:** Valor médio por cobrança emitida. Útil para comparar com benchmarks do setor de saúde.

---

#### Despesas Operacionais (Premissa)
```dax
Despesas Operacionais = [Receita Total] * 0.6
```
**Descrição:** Estimativa de despesas operacionais baseada em premissas assumidas, pois o dataset não fornece dados reais de despesas. A composição é:
- Médicos: 30% da receita
- Infraestrutura: 20% da receita
- Administrativo: 10% da receita
- **Total: 60% da receita**

---

#### EBITDA ($)
```dax
EBITDA = [Margem Bruta] - [Despesas Operacionais]
```
**Descrição:** Resultado antes de juros, impostos, depreciação e amortização. Estimado com base nas premissas de despesas operacionais.

---

#### Margem EBITDA (%)
```dax
Margem EBITDA % = 
DIVIDE([EBITDA], [Receita Total], 0)
```
**Descrição:** Percentual do EBITDA sobre a receita total. Indica a eficiência operacional do hospital.

---

#### Valuation ($)
```dax
Valuation = [EBITDA] * [Multiplo EV/EBITDA]
```
**Descrição:** Estimativa do valor de mercado do hospital com base no múltiplo EV/EBITDA. O múltiplo utilizado é uma premissa baseada em benchmarks do setor de saúde (tipicamente entre 8x e 12x para hospitais).  
**Nota:** Este é um indicador estimado para fins analíticos e de portfólio. Não representa uma avaliação financeira formal.

---

### 8.2 Medidas de Pagamento — Visão Tática

---

#### Total Pago
```dax
Total Pago = 
CALCULATE(
    SUM(billing[amount]),
    billing[payment_status] = "Paid"
)
```
**Descrição:** Soma dos valores efetivamente recebidos pelo hospital.

---

#### Total Pendente
```dax
Total Pendente = 
CALCULATE(
    SUM(billing[amount]),
    billing[payment_status] = "Pending"
)
```
**Descrição:** Soma dos valores ainda em aberto, que podem ser recuperados.

---

#### Total Falho
```dax
Total Falho = 
CALCULATE(
    SUM(billing[amount]),
    billing[payment_status] = "Failed"
)
```
**Descrição:** Soma dos valores com falha no processo de cobrança. Representa perda financeira potencial.

---

#### % Pagamentos Pagos
```dax
% Pagamentos Pagos = 
DIVIDE([Total Pago], [Receita Total], 0)
```
**Descrição:** Proporção do valor efetivamente recebido sobre o total faturado.

---

#### % Pagamentos Falhos
```dax
% Pagamentos Falhos = 
DIVIDE([Total Falho], [Receita Total], 0)
```
**Descrição:** Proporção de cobranças com falha sobre o total faturado. Indicador crítico de risco financeiro.

---

### 8.3 Medidas Operacionais — Visão Operacional

---

#### Total Consultas
```dax
Total Consultas = COUNTROWS(appointments)
```
**Descrição:** Contagem total de registros na tabela de agendamentos.

---

#### Consultas Concluídas
```dax
Consultas Concluídas = 
CALCULATE(
    COUNTROWS(appointments),
    appointments[status] = "Completed"
)
```

---

#### Consultas Canceladas
```dax
Consultas Canceladas = 
CALCULATE(
    COUNTROWS(appointments),
    appointments[status] = "Cancelled"
)
```

---

#### No-show
```dax
No-show = 
CALCULATE(
    COUNTROWS(appointments),
    appointments[status] = "No-show"
)
```

---

#### Taxa de Cancelamento (%)
```dax
Taxa de Cancelamento % = 
DIVIDE([Consultas Canceladas], [Total Consultas], 0)
```
**Descrição:** Percentual de consultas canceladas sobre o total agendado.

---

#### Taxa de No-show (%)
```dax
Taxa No-show % = 
DIVIDE([No-show], [Total Consultas], 0)
```
**Descrição:** Percentual de pacientes que não compareceram sem cancelamento prévio.

---

#### Dias de Espera (Média)
```dax
Dias de Espera Médio = 
AVERAGEX(
    unified_table_modified,
    DATEDIFF(
        unified_table_modified[appointment_date],
        unified_table_modified[treatment_date],
        DAY
    )
)
```
**Descrição:** Média de dias entre a data do agendamento e a data de realização do tratamento. Calculado sobre a tabela unificada que contém ambas as datas.


---

## 9. Insights e Recomendações

### 9.1 Diagnóstico Financeiro

#### Problema: Ausência de Markup na Precificação

No dataset, o campo `billing.amount` é idêntico ao campo `treatments.cost`, o que indica que o hospital está cobrando exatamente o custo do procedimento, sem margem de lucro. Somado às despesas operacionais estimadas em 60% da receita, o negócio opera com **EBITDA negativo**.

**Recomendação:** Revisar a política de precificação dos procedimentos. Benchmarks do setor de saúde sugerem margens brutas entre 20% e 40% para hospitais de médio porte.

---

#### Problema: Alto Volume de Pagamentos Falhos e Pendentes

A distribuição dos status de pagamento revela que uma parcela significativa das cobranças não é convertida em receita efetiva:

| Status | Característica |
|---|---|
| **Paid** | Receita confirmada |
| **Pending** | Concentrado em Insurance — indica atraso no reembolso das operadoras |
| **Failed** | Concentrado em Cash — indica ausência de análise de crédito prévia |

**Recomendações:**
- **Insurance (Pendente):** Revisar os contratos com operadoras de saúde e os prazos de reembolso. Implementar processo de follow-up automatizado com as operadoras.
- **Cash (Falho):** Implementar análise de crédito ou exigência de depósito antecipado para pagamentos em dinheiro. Avaliar se o método Cash deve ser mantido para procedimentos de alto custo.

---

### 9.2 Diagnóstico Operacional

#### Problema: Alta Taxa de Cancelamento e No-show

A análise dos agendamentos revela que uma proporção relevante das consultas não resulta em atendimento efetivo, seja por cancelamento ou ausência do paciente.

**Recomendações:**
- Implementar sistema de lembretes automáticos (SMS/e-mail) 24h e 2h antes da consulta.
- Criar política de confirmação de presença com antecedência mínima de 24h.
- Analisar se cancelamentos estão concentrados em algum médico, especialidade ou horário específico.
- Avaliar a criação de lista de espera para aproveitar vagas canceladas.

---

#### Problema: Sazonalidade em Abril e Novembro

Picos de agendamento foram identificados em **abril** e **novembro**, com possível queda em outros períodos.

**Recomendações:**
- Planejar capacidade de atendimento com antecedência para os meses de pico.
- Investigar causas da sazonalidade (campanhas de saúde, datas comemorativas, renovação de planos).
- Criar estratégias de captação para os meses de baixa demanda.

---

### 9.3 Resumo Executivo dos Insights

| # | Insight | Impacto | Urgência |
|---|---|---|---|
| 1 | Negócio não é autossustentável com a precificação atual | Alto | Crítica |
| 2 | Pagamentos via Insurance com alto índice de pendência | Alto | Alta |
| 3 | Pagamentos via Cash com alto índice de falha | Médio | Alta |
| 4 | Alta taxa de no-show e cancelamento | Médio | Média |
| 5 | Sazonalidade em abril e novembro não gerenciada | Baixo | Baixa |

---

## 10. Limitações e Premissas

### 10.1 Limitações do Dataset

| Limitação | Impacto |
|---|---|
| Dataset simulado (não real) | Padrões podem não refletir comportamento hospitalar real |
| Apenas 200 registros por tabela | Análises estatísticas têm baixa significância amostral |
| Ausência de dados de despesas reais | EBITDA e Valuation são estimativas baseadas em premissas |
| Ausência de dados de estoque e insumos | Custo real dos procedimentos pode ser diferente |
| Período único (2023) | Impossibilidade de análise de tendência histórica real |
| `billing.amount` = `treatments.cost` | Não há markup real no dataset — limitação estrutural |

### 10.2 Premissas Assumidas

| Premissa | Valor | Justificativa |
|---|---|---|
| Despesas com médicos | 30% da receita | Benchmark do setor de saúde |
| Despesas com infraestrutura | 20% da receita | Benchmark do setor de saúde |
| Despesas administrativas | 10% da receita | Benchmark do setor de saúde |
| **Total de despesas operacionais** | **60% da receita** | Soma das premissas acima |
| Múltiplo EV/EBITDA | Definido no modelo | Baseado em benchmarks de mercado para hospitais |

### 10.3 Observações sobre Qualidade dos Dados

- Alguns registros na tabela `unified_table_modified.csv` apresentam `treatment_date` posterior ao ano de 2023 (ex.: 2024-01-03), indicando que o tratamento foi realizado após o período de agendamento — comportamento esperado para procedimentos com longa fila de espera.
- O campo `gender` na tabela `patients` apresenta inconsistência: alguns registros com nomes tipicamente femininos têm `gender = 'M'` e vice-versa. Isso é uma característica do dataset simulado e não impacta as análises financeiras e operacionais.
- Não há dados de pacientes sem agendamento (pacientes cadastrados mas sem consulta), o que limita análises de churn ou retenção.

---

## 11. Como Executar o Projeto

### 11.1 Pré-requisitos

- [Power BI Desktop](https://powerbi.microsoft.com/pt-br/desktop/) instalado (gratuito)
- [R](https://cran.r-project.org/) instalado (opcional, apenas para recriar o join)
- Git instalado (opcional, para clonar o repositório)

### 11.2 Passo a Passo

**Opção A — Apenas visualizar o dashboard:**

```
1. Baixe o arquivo pbix/Hospital_data_case.pbix
2. Abra no Power BI Desktop
3. Explore as três visões do dashboard
```

**Opção B — Executar com dados atualizados:**

```
1. Clone o repositório:
   git clone https://github.com/micheleoliveiracod/Hospital_data_case.git

2. Abra o Power BI Desktop

3. Abra o arquivo pbix/Hospital_data_case.pbix

4. Vá em Transformar Dados → Configurações da Fonte de Dados

5. Atualize o caminho para a pasta /data do repositório clonado

6. Clique em Fechar e Aplicar

7. Clique em Atualizar para recarregar os dados
```

**Opção C — Recriar o join com R:**

```r
# Instale as dependências
install.packages(c("readr", "dplyr"))

# Execute o script
source("data/Join/script_join.R")

# O arquivo unified_table_modified.csv será gerado em data/Join/
```

### 11.3 Estrutura do Repositório

```
Hospital_data_case/
├── data/
│   ├── appointments.csv       # Agendamentos
│   ├── billing.csv            # Faturamento
│   ├── doctors.csv            # Médicos
│   ├── patients.csv           # Pacientes
│   ├── treatments.csv         # Tratamentos
│   └── Join/
│       ├── script_join.R      # Script R para join
│       └── unified_table_modified.csv  # Tabela unificada
├── documentation/
│   └── dashboard_documentation.md  # Este documento
├── images/
│   └── image2.png             # Preview do dashboard
├── pbix/
│   └── Hospital_data_case.pbix  # Arquivo Power BI
├── README.md
└── LICENSE
```

---

## 12. Glossário

| Termo | Definição |
|---|---|
| **EBITDA** | Earnings Before Interest, Taxes, Depreciation and Amortization — Lucro antes de juros, impostos, depreciação e amortização. Indicador de performance operacional. |
| **Valuation** | Estimativa do valor de mercado de uma empresa, calculado como múltiplo do EBITDA. |
| **EV/EBITDA** | Enterprise Value / EBITDA — Múltiplo de mercado usado para estimar o valor de uma empresa em relação ao seu resultado operacional. |
| **Ticket Médio** | Valor médio por transação ou atendimento. |
| **Margem Bruta** | Diferença entre receita e custo direto dos serviços prestados. |
| **Star Schema** | Modelo de dados dimensional onde uma tabela fato central é conectada a tabelas dimensão. Padrão recomendado para Power BI. |
| **DAX** | Data Analysis Expressions — Linguagem de fórmulas do Power BI para criação de medidas e colunas calculadas. |
| **Power Query** | Ferramenta de ETL integrada ao Power BI para transformação e limpeza de dados. |
| **No-show** | Paciente que não compareceu à consulta agendada sem cancelamento prévio. |
| **KPI** | Key Performance Indicator — Indicador-chave de performance. |
| **Drill-down** | Navegação para um nível mais detalhado de granularidade em um visual. |
| **Slicer** | Filtro visual interativo no Power BI que permite segmentar os dados exibidos. |
| **Insurance** | Método de pagamento via plano de saúde / seguro médico. |
| **Pending** | Status de pagamento em aberto, aguardando processamento ou reembolso. |
| **Failed** | Status de pagamento com falha no processamento — cobrança não efetivada. |
| **Full Join** | Operação de junção de tabelas que retorna todos os registros de ambas as tabelas, com `NULL` onde não há correspondência. |

---

## Informações do Projeto

| Campo | Valor |
|---|---|
| **Projeto** | Hospital Analytics Dashboard |
| **Tipo** | Case de Portfólio Profissional |
| **Ferramenta Principal** | Power BI Desktop |
| **Ferramentas Auxiliares** | DAX, Power Query, R, Figma |
| **Dataset** | Kaggle — Hospital Management Dataset |
| **Período dos Dados** | Janeiro a Dezembro de 2023 |
| **Número de Registros** | 200 por tabela (1.000 total) |
| **Licença** | MIT License |
| **Repositório** | https://github.com/micheleoliveiracod/Hospital_data_case |

---

*Documentação elaborada para fins de portfólio profissional. Os dados utilizados são simulados e de domínio público.*
