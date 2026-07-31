# Omena Consulting Status Reporting Process Guide

Este documento explica como alimentar a ferramenta de forma consistente para que os dashboards mostrem o status real dos projetos, atrasos, impactos, riscos, progresso, stage e proximas acoes.

## Objetivo

A ferramenta nao deve ser usada apenas como um formulario de texto. Ela funciona como uma base estruturada de gestao. Cada campo alimenta um indicador.

Quando os reports sao preenchidos de forma inconsistente, os dashboards podem mostrar:

- Projetos duplicados.
- Workstreams contados como projetos.
- Atrasos sem causa.
- Projetos sem responsavel claro.
- Progresso sem relacao com stage.
- Falta de visibilidade sobre o que esta bloqueado, entregue ou em risco.

## Modelo Logico

Use sempre esta logica:

| Conceito | Como usar | Exemplo correto |
| --- | --- | --- |
| Product | Produto/projeto principal. Nao e uma tarefa. | Survey software |
| Feature / workstream | Entrega, modulo, atividade ou frente de trabalho dentro do produto. | Client onboarding flow |
| Owner | Uma pessoa responsavel pelo status e pelo proximo passo. | Nadishani |
| Participants | Pessoas envolvidas, mas nao responsaveis finais. | QA, designer, developer |
| Reporting week | Semana de referencia do report. | 2026-07-20 - 2026-07-24 |
| Stage | Onde o workstream esta no ciclo de entrega. | QA Review |
| Health | Confianca de entrega. | On Track, In Progress, At Risk, Paused |
| Progress | Percentual real de conclusao do workstream. | 70% |
| End date | Data atual esperada de entrega. | 2026-07-31 |
| Next action | O que precisa acontecer agora. | QA to finish regression by Friday |

## Regra Principal

Um report deve representar:

**1 produto + 1 workstream + 1 owner + 1 semana de reporte**

Nao misture varios workstreams no mesmo report. Nao crie um produto novo para cada feature. Nao use o campo Product para explicar a atividade.

## Quando Criar Ou Atualizar Um Report

Crie um novo report quando:

- For uma nova semana de reporte.
- For um novo workstream.
- For uma nova frente de entrega dentro de um produto.

Atualize um report existente quando:

- O status pertence a mesma semana.
- O mesmo workstream mudou de health, stage, prazo, blocker ou next action.
- Voce esta corrigindo informacao incompleta.

Evite duplicar cards para o mesmo workstream na mesma semana. Isso distorce workload, progresso, atrasos e ranking de riscos.

## Como Preencher Cada Campo

### Product

Escolha o produto/projeto principal. Este campo e usado para contar projetos ativos e gerar overview por produto.

Bom exemplo:

- Product: `Survey software`
- Feature / workstream: `New user roles from Baylee Holder`

Exemplo ruim:

- Product: `New user roles from Baylee Holder`
- Feature / workstream: `Working on it`

### Feature / Workstream

Descreva a entrega especifica. Deve ser claro o bastante para alguem entender o que esta sendo acompanhado.

Bom:

- `Billing validation flow`
- `Client implementation checklist`
- `QA regression for mobile onboarding`

Ruim:

- `Update`
- `In progress`
- `Testing`

### Owner

Use uma unica pessoa responsavel. O owner deve conseguir responder:

- Qual e o status atual?
- Qual e o blocker?
- Qual e a proxima acao?
- Quem precisa decidir algo?

Se mais pessoas participam, use `Participants`.

### Type of product

Use:

- `Legacy` para produto existente, manutencao, migracao ou melhoria em solucao ja ativa.
- `New product` para produto novo, modulo novo ou iniciativa ainda em construcao.

### Role

Use o papel principal do owner no report:

- `Product Manager`
- `UI/UX`

Este campo alimenta workload e distribuicao por time.

### Reporting week

Sempre selecione a semana correta. Quando o report for semanal, use a semana de segunda a sexta.

Regra:

- Segunda-feira representa a semana completa.
- Se selecionar um dia especifico, o dashboard pode focar naquele dia.
- Sabado e domingo nao devem ser usados como reporting week.

### Start Date

Use a data em que o workstream realmente comecou. Isso ajuda a medir tempo de ciclo.

### End Date

Use a data atual esperada de entrega. Este campo e essencial para:

- Ahead of Schedule
- On Time
- Minor Delay
- Major Delay
- Due soon
- Delayed
- Delivery Timeline

Se o end date estiver vazio, a ferramenta nao consegue calcular o status de prazo corretamente.

### Depends On

Use quando o workstream depende de outro trabalho, time, sistema, cliente ou decisao.

Exemplos:

- Depends on: `DevOps environment setup`
- Depends on: `Client approval`
- Depends on: `API credentials`

Isso ajuda a identificar caminho critico.

### Health

Use health para indicar a confianca de entrega:

| Health | Quando usar |
| --- | --- |
| On Track | Trabalho avancando conforme esperado, sem blocker relevante. |
| In Progress | Trabalho ativo, mas ainda sem certeza de entrega final. |
| At Risk | Existe risco real de atraso, blocker, dependencia ou decisao pendente. |
| Paused | Trabalho parado intencionalmente por prioridade, dependencia ou decisao. |

### Progress

Use uma estimativa realista, nao otimista.

Sugestao:

- 0-20%: descoberta, alinhamento ou inicio.
- 30-50%: execucao em andamento.
- 60-80%: entrega em validacao, QA, revisao ou cliente.
- 90-99%: quase pronto, mas ainda falta validacao final.
- 100%: entregue e sem follow-up aberto.

### Stage

Stage e obrigatorio porque mostra onde o trabalho esta no fluxo.

| Stage | Como interpretar |
| --- | --- |
| Discovery | Escopo ainda sendo entendido. |
| Research | Levantamento, analise ou investigacao. |
| Documentation | Documentacao, requisitos, guia ou material. |
| Demo | Demonstracao ou validacao inicial. |
| Work in Progress | Execucao ativa. |
| Wireframes | Estrutura de tela ou fluxo. |
| Visual Design | Design visual. |
| Prototype | Prototipo navegavel ou validacao de conceito. |
| Design Review | Revisao de design. |
| Dev Handoff | Entrega para desenvolvimento. |
| Testing | Testes em andamento. |
| QA | Validacao de qualidade. |
| QA Review | Revisao final de QA. |
| Environment | Ambiente, credenciais, deploy ou setup tecnico. |
| Client implementation | Implementacao, onboarding ou validacao com cliente. |
| Release | Preparacao ou execucao de release. |
| Paused | Workstream parado. |
| Completed | Workstream entregue. |

Quando o stage for `Completed`, o workstream deve ser considerado entregue. Use somente quando nao houver blocker, decisao ou next action pendente para aquela entrega.

### Summary

Escreva uma explicacao curta do que mudou na semana.

Bom:

> QA completed regression for the onboarding flow. Two defects remain open and require DevOps support before client validation.

Ruim:

> Still working.

### Win

Registre uma conquista concreta da semana.

Bom:

- `Client approved the revised onboarding flow.`
- `QA finished first regression cycle.`

Ruim:

- `Progress`
- `Meeting done`

### Blocker Or Risk

Preencha quando existe algo que pode atrasar, bloquear ou reduzir qualidade.

Bom:

- `API credentials are missing, blocking QA validation.`
- `Scope is still unclear because client has not confirmed final workflow.`

Se nao houver blocker, use:

- `No blocker captured.`

### Next Action

Sempre deve responder: quem faz o que ate quando?

Bom:

- `DevOps to provide API credentials by Wednesday.`
- `PM to confirm final scope with client by Friday.`

Ruim:

- `Follow up`
- `Continue`
- `Check`

### Delay Root Cause

Preencha quando o workstream estiver atrasado ou com risco de atraso.

Exemplos:

- `Dependency`
- `Client decision`
- `Environment`
- `Scope change`
- `Resource availability`
- `Technical issue`

### Date Change Reason

Use quando a data de entrega mudar. A ferramenta diferencia:

- Nova data antes da data anterior: `Ahead of Schedule`
- Nova data dentro do prazo: `On Time`
- Atraso ate 10%: `Minor Delay`
- Atraso acima de 10%: `Major Delay`

Se a data foi antecipada, nao classifique como postponed.

### Corrective Action Owner

Pessoa responsavel por resolver o blocker ou conduzir a acao corretiva.

Pode ser diferente do owner do report.

### Action Target Date

Data esperada para concluir a proxima acao. Sem essa data, o action queue perde forca.

### Action Status

Use para acompanhar a execucao da proxima acao:

- `Open`
- `In Progress`
- `Waiting`
- `Done`

### Decision Needed

Use quando lideranca, cliente ou outro time precisa decidir algo.

Bom:

- `Need CEO approval to pause legacy migration and redirect team to production defects.`

## Como O Dashboard Calcula Status Do Projeto

O status do projeto nao vem de um unico campo. Ele e calculado pela combinacao dos workstreams ativos.

Para entender um produto, olhe nesta ordem:

1. Quantos workstreams existem no produto.
2. Quantos estao `Completed`.
3. Quantos estao em stage ativo como `Work in Progress`, `Testing`, `QA`, `Client implementation`.
4. Quantos tem health `At Risk` ou `Paused`.
5. Quantos tem blocker/risk preenchido.
6. Quantos tem schedule `Major Delay` ou `Minor Delay`.
7. Se existe next action clara e com owner.

## Classificacao Recomendada Para Status Do Projeto

| Situacao | Interpretacao |
| --- | --- |
| Todos workstreams relevantes estao Completed | Produto entregue para o periodo analisado. |
| Maioria On Track e next actions claras | Produto saudavel. |
| Existe blocker, mas ha plano claro | Produto em atencao. |
| Existe blocker sem owner ou data | Produto em risco. |
| Ha Major Delay ou decisao pendente | Produto precisa de gestao. |
| Stage Paused sem motivo claro | Produto precisa de decisao. |

## Como Usar Cada Pagina

### Portfolio Dashboard

Use para responder:

- Quantos produtos estao ativos?
- Quantos workstreams existem?
- Onde estao os riscos?
- Qual e o progresso medio?
- Qual e o stage mix?
- O que esta atrasado?

### Executive View

Use para mostrar CEO/CTO:

- Produtos em risco.
- Decisoes necessarias.
- Bloqueios criticos.
- Status executivo sem detalhes excessivos.

### Incidents & Delays

Use para analisar:

- Atrasos.
- Motivos de atraso.
- Workstreams impactados.
- Blockers.
- Itens que precisam de acao.

### Delivery Timeline

Use para ver:

- Evolucao por data.
- Dependencias.
- Caminho critico.
- Workstreams sem end date.

### Status Center

Use para:

- Criar report.
- Editar report.
- Ver historico.
- Exportar dados.

### Report Quality Review

Use para identificar reports fracos:

- Sem next action.
- Sem blocker claro.
- Sem stage.
- Sem data.
- Sem decisao.
- Com resumo generico.

### Weekly Project Brief

Use para reuniao de managers:

- Overview por produto.
- Narrativa curta.
- Riscos.
- Proximas acoes.
- Stage e progresso.

### Owner Weekly Feedback

Use para enviar feedback individual:

- O que o owner reportou.
- O que precisa melhorar.
- Quais acoes devem ser tomadas.
- Quais licoes aprendidas reforcar.

## Checklist Antes De Salvar

Antes de salvar um report, confirme:

- Product e um produto real, nao uma tarefa.
- Feature/workstream descreve uma entrega especifica.
- Owner e uma unica pessoa responsavel.
- Reporting week esta correta.
- Stage foi selecionado.
- Progress combina com o stage.
- End date foi informado.
- Health reflete o risco real.
- Summary explica o que mudou.
- Win e concreto.
- Blocker/risk esta claro ou marcado como sem blocker.
- Next action tem acao, responsavel e prazo.
- Se houver atraso, delay root cause foi preenchido.
- Se houver mudanca de data, date change reason foi preenchido.
- Se houver decisao, decision needed esta claro.

## Exemplos

### Exemplo Ruim

| Campo | Valor |
| --- | --- |
| Product | Login screen |
| Feature/workstream | Working |
| Owner | Team |
| Stage | Blank |
| Progress | 80 |
| End date | Blank |
| Summary | In progress |
| Win | Meeting |
| Blocker/risk | Blank |
| Next action | Continue |

Problema: esse report nao gera metrica confiavel. Nao da para saber produto, responsavel, prazo, risco ou proxima acao.

### Exemplo Bom

| Campo | Valor |
| --- | --- |
| Product | Survey software |
| Feature/workstream | Client onboarding flow |
| Owner | Nadishani |
| Participants | QA, DevOps |
| Type of product | New product |
| Role | Product Manager |
| Reporting week | 2026-07-20 - 2026-07-24 |
| Start date | 2026-07-08 |
| End date | 2026-07-31 |
| Health | At Risk |
| Progress | 70 |
| Stage | QA Review |
| Summary | QA completed first validation. Two defects remain open and environment credentials are blocking final regression. |
| Win | Client approved the revised onboarding workflow. |
| Blocker/risk | DevOps credentials are missing, blocking QA regression. |
| Next action | DevOps to provide credentials by Wednesday; QA to restart regression after access is confirmed. |
| Delay root cause | Environment |
| Corrective action owner | DevOps |
| Action target date | 2026-07-24 |
| Action status | Open |
| Priority | High |

Resultado: o dashboard consegue mostrar risco, prazo, owner, stage, next action e impacto.

## Cadencia Semanal Recomendada

### Segunda-feira

- Criar ou atualizar reports da semana.
- Confirmar workstreams ativos.
- Atualizar stage, end date e dependencies.

### Quarta-feira

- Revisar blockers.
- Atualizar next action.
- Escalar decisoes pendentes.

### Sexta-feira

- Fechar status da semana.
- Marcar `Completed` quando entregue.
- Atualizar progresso real.
- Garantir que todas as acoes tenham owner e data.

## KPIs Que Dependem De Preenchimento Correto

| KPI | Depende de |
| --- | --- |
| Active projects | Product + workstreams ativos |
| Workstreams | Feature/workstream |
| Delivered workstreams | Stage = Completed |
| Stage mix | Stage |
| Schedule delay | Start date, end date, date changes |
| Ahead of Schedule | End date antecipado |
| On Time | End date dentro do prazo |
| Minor/Major Delay | End date atrasado |
| Blocker concentration | Blocker/risk + product |
| Action queue | Next action + action owner + action status |
| Owner workload | Owner + workstreams |
| Report quality | Campos faltando ou genericos |
| Weekly feedback | Owner + report quality + risks + actions |
| Project brief | Product + stage + health + progress + actions |

## Regra De Ouro Para Reuniao De Status

Para falar sobre um produto na reuniao, use este roteiro:

1. Produto: qual produto esta sendo discutido?
2. Status geral: saudavel, em atencao, em risco ou entregue?
3. Stage predominante: onde o trabalho esta?
4. Progresso: quanto foi concluido?
5. Risco: existe blocker ou atraso?
6. Impacto: o atraso afeta entrega, cliente ou outro time?
7. Next action: quem faz o que ate quando?
8. Decisao: precisa de lideranca?

Se o report nao responde essas perguntas, ele precisa ser melhorado antes de entrar na reuniao.

