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
| Baseline end date | Data original combinada para comparar mudancas de prazo. | 2026-07-28 |
| Depends on | Dependencia que pode bloquear ou atrasar a entrega. | API credentials |
| Milestone | Marco da entrega usado para leitura executiva. | QA sign-off |
| Next action | O que precisa acontecer agora. | QA to finish regression by Friday |
| Corrective action owner | Responsavel por resolver blocker, atraso ou acao corretiva. | DevOps |
| Action target date | Data alvo da acao corretiva/proxima acao. | 2026-07-24 |
| Action status | Situacao da acao aberta. | Open, In Progress, Waiting, Done |
| Decision needed | Decisao que precisa ser tomada para desbloquear ou acelerar. | Approve scope reduction |

## Como Os Campos Se Conectam Aos Indicadores

Pense no formulario como um sistema conectado. Cada campo alimenta uma leitura diferente:

| Campo preenchido | O que ele responde | Onde aparece |
| --- | --- | --- |
| Product | Qual produto/projeto esta sendo acompanhado? | Portfolio Dashboard, Executive View, Weekly Project Brief, Manager Meeting |
| Feature / workstream | Qual entrega especifica esta em andamento? | Workstream Health, Delivery Timeline, Status Center |
| Owner | Quem e responsavel pelo status e follow-up? | Work Balance, Owner Feedback, Send Weekly Feedback |
| Participants | Quem esta envolvido sem ser responsavel final? | Status Center, historico do report |
| Type of product | E produto legado ou novo? | Filtros, product mix, portfolio segmentation |
| Role | O trabalho e de Product Manager ou UI/UX? | Work Balance, filtros executivos, carga por time |
| Reporting week | A qual semana o status pertence? | Todos os dashboards semanais, feedback semanal, historico |
| Start date | Quando a entrega comecou? | Cycle time, timeline, contexto de atraso |
| Baseline end date | Qual era a data original prometida? | Schedule movement, date change logic |
| End date | Qual e a data atual esperada? | Delayed, due soon, ahead of schedule, on time |
| Date change reason | Por que o prazo mudou? | Report History, schedule analysis, manager review |
| Depends on | Qual dependencia pode travar a entrega? | Delivery Timeline, critical path, Incident & Delays |
| Delay root cause | Qual e a causa principal do atraso? | Incident Report, root cause trends, action queue |
| Health | A entrega esta saudavel, em progresso, em risco ou pausada? | Portfolio Dashboard, Executive View, health mix |
| Progress | Quanto foi concluido? | Average progress, product brief, owner performance |
| Stage | Onde o workstream esta no fluxo? | Stage Mix, Delivery Timeline, delivered workstreams |
| Milestone | Qual marco esta sendo acompanhado? | Delivery Timeline, project talk track |
| Summary | O que mudou nesta semana? | Project brief, report cards, executive narrative |
| Win | Qual conquista deve ser comunicada? | Weekly Project Brief, Manager Meeting, Owner Feedback |
| Blocker or risk | O que pode impedir a entrega? | Incidents & Delays, Action Items, risk radar |
| Next action | O que precisa acontecer agora? | Action Items, feedback semanal, executive decision queue |
| Corrective action owner | Quem deve resolver o problema? | Action queue, accountability, coaching feedback |
| Action target date | Ate quando a acao precisa acontecer? | Action queue, overdue actions, management follow-up |
| Action status | A acao esta aberta, em andamento, esperando ou concluida? | Action Items, weekly follow-up |
| Decision needed | Que decisao precisa de lideranca/cliente/time? | Executive View, Manager Meeting, decision queue |
| Risk impact | Qual o impacto se o risco acontecer? | Incident severity, executive prioritization |
| Time to solve | Quanto tempo estimado para resolver? | Risk prioritization, action planning |
| Priority | Qual urgencia do item? | Executive View, Report Quality Review, Action Items |

Se um campo fica vazio, a pagina que depende dele perde qualidade. Exemplo: sem `End date`, o sistema nao sabe se o workstream esta atrasado. Sem `Next action`, o report vira apenas uma descricao, nao uma acao gerenciavel.

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

Conexao:

- Ajuda a entender ha quanto tempo o workstream esta ativo.
- Da contexto para progresso baixo em atividades antigas.
- Apoia leitura de ciclo de entrega na timeline.

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

### Baseline End Date

Use a data original prometida ou planejada antes de qualquer mudanca.

Conexao:

- Compara plano original versus data atual.
- Ajuda a identificar mudanca real de prazo.
- Evita classificar como `Postponed` quando a data foi antecipada.

Exemplo:

- Baseline end date: `2026-08-07`
- End date atualizado: `2026-07-30`
- Interpretacao: entrega antecipada, portanto `Ahead of Schedule`.

### Depends On

Use quando o workstream depende de outro trabalho, time, sistema, cliente ou decisao.

Exemplos:

- Depends on: `DevOps environment setup`
- Depends on: `Client approval`
- Depends on: `API credentials`

Isso ajuda a identificar caminho critico.

Conexao:

- Alimenta Delivery Timeline.
- Ajuda a detectar critical path.
- Mostra por que um workstream aparentemente ativo nao avanca.

### Milestone

Use milestone para indicar o marco principal da entrega.

Exemplos:

- `Requirements approved`
- `Design signed off`
- `Dev handoff complete`
- `QA sign-off`
- `Client implementation`
- `Release ready`

Conexao:

- Ajuda a explicar progresso sem depender apenas de percentual.
- Melhora a narrativa executiva.
- Mostra em que checkpoint o projeto esta na Delivery Timeline.

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

Conexao:

- Alimenta Incidents & Delays.
- Ajuda a gerar tendencias de causa raiz.
- Permite mostrar se os atrasos sao causados por cliente, tecnologia, ambiente, dependencia ou escopo.

### Date Change Reason

Use quando a data de entrega mudar. A ferramenta diferencia:

- Nova data antes da data anterior: `Ahead of Schedule`
- Nova data dentro do prazo: `On Time`
- Atraso ate 10%: `Minor Delay`
- Atraso acima de 10%: `Major Delay`

Se a data foi antecipada, nao classifique como postponed.

Conexao:

- Aparece no historico do report.
- Explica mudancas de prazo para reunioes de gestao.
- Ajuda a separar atraso real de replanejamento saudavel.

### Como Preencher Replanejamento De Data

Sempre que mudar a data, preencha estes campos juntos:

| Campo | Como preencher |
| --- | --- |
| Baseline end date | A data original combinada antes da mudanca. |
| End date | A nova data esperada de entrega. |
| Date change reason | Por que a data mudou. |
| Delay root cause | A causa principal, quando a mudanca representa atraso. |
| Decision needed | A decisao que precisa ser tomada, se depender de lideranca, cliente ou outro time. |

Regra:

- Se `End date` ficou depois do `Baseline end date`, explique se e atraso real ou replanejamento aprovado.
- Se `End date` ficou antes do `Baseline end date`, isso e entrega antecipada e deve aparecer como `Ahead of Schedule`.
- Se a data mudou por decisao de escopo, prioridade ou dependencia externa, explique isso em `Date change reason`.
- Se a data mudou porque algo bloqueou a entrega, preencha tambem `Delay root cause`, `Blocker/risk`, `Corrective action owner` e `Action target date`.

Exemplo de atraso real:

| Campo | Valor |
| --- | --- |
| Baseline end date | 2026-07-26 |
| End date | 2026-08-02 |
| Date change reason | QA regression could not start because environment credentials were not available. |
| Delay root cause | Environment |
| Blocker/risk | DevOps credentials are blocking regression. |
| Corrective action owner | DevOps |
| Action target date | 2026-07-24 |

Leitura esperada: atraso com causa operacional clara. Deve aparecer em Incidents & Delays e Action Items.

Exemplo de replanejamento aprovado:

| Campo | Valor |
| --- | --- |
| Baseline end date | 2026-07-26 |
| End date | 2026-08-09 |
| Date change reason | Leadership approved moving this delivery after the production issue resolution. |
| Delay root cause | Priority change |
| Decision needed | No decision pending; new date already approved. |
| Action status | In Progress |

Leitura esperada: existe mudanca de prazo, mas a narrativa mostra que foi uma decisao aprovada, nao apenas atraso sem controle.

Exemplo de entrega antecipada:

| Campo | Valor |
| --- | --- |
| Baseline end date | 2026-08-07 |
| End date | 2026-07-30 |
| Date change reason | Development finished earlier than planned after reusing the existing component library. |
| Health | On Track |
| Stage | Release |

Leitura esperada: `Ahead of Schedule`. Nao deve ser marcado como postponed.

### Corrective Action Owner

Pessoa responsavel por resolver o blocker ou conduzir a acao corretiva.

Pode ser diferente do owner do report.

Conexao:

- Alimenta accountability no Action Items.
- Ajuda a identificar quem precisa agir, mesmo quando o owner do report nao e quem resolve.

### Action Target Date

Data esperada para concluir a proxima acao. Sem essa data, o action queue perde forca.

Conexao:

- Permite cobrar follow-up.
- Ajuda a priorizar acoes vencidas ou proximas do prazo.

### Action Status

Use para acompanhar a execucao da proxima acao:

- `Open`
- `In Progress`
- `Waiting`
- `Done`

Conexao:

- Mostra se a acao saiu do papel.
- Evita que o mesmo blocker apareca toda semana sem progresso.

### Decision Needed

Use quando lideranca, cliente ou outro time precisa decidir algo.

Bom:

- `Need CEO approval to pause legacy migration and redirect team to production defects.`

Conexao:

- Alimenta Executive View e Manager Meeting.
- Deve ser usado quando o problema nao pode ser resolvido apenas pelo owner.

### Risk Impact

Use para indicar o tamanho do impacto se o risco acontecer.

Exemplos:

- `Low`: impacto pequeno, sem afetar entrega principal.
- `Medium`: pode afetar data, qualidade ou escopo.
- `High`: pode afetar cliente, release, receita, dependencia critica ou equipe executiva.

Conexao:

- Ajuda a priorizar riscos na visao executiva.
- Distingue pequenos problemas de riscos que precisam de decisao.

### Time To Solve

Use para indicar o esforco ou tempo esperado para resolver o blocker.

Exemplos:

- `Short`: pode ser resolvido rapidamente.
- `Medium`: precisa de acompanhamento.
- `Long`: pode impactar planejamento, equipe ou data.

Conexao:

- Ajuda a decidir se precisa de escalacao.
- Ajuda a planejar follow-up semanal.

### Priority

Use para indicar urgencia.

Conexao:

- Alimenta ranking de Report Quality Review.
- Destaca itens criticos em Executive View e Action Items.

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
| Baseline end date | 2026-07-26 |
| End date | 2026-07-31 |
| Depends on | DevOps environment access |
| Delay root cause | Environment |
| Date change reason | QA regression moved because credentials were not available on time. |
| Health | At Risk |
| Progress | 70 |
| Stage | QA Review |
| Milestone | QA sign-off |
| Summary | QA completed first validation. Two defects remain open and environment credentials are blocking final regression. |
| Win | Client approved the revised onboarding workflow. |
| Blocker/risk | DevOps credentials are missing, blocking QA regression. |
| Next action | DevOps to provide credentials by Wednesday; QA to restart regression after access is confirmed. |
| Corrective action owner | DevOps |
| Action target date | 2026-07-24 |
| Action status | Open |
| Decision needed | Confirm whether release can move without the optional reporting widget. |
| Risk impact | High |
| Time to solve | Medium |
| Priority | High |

Resultado: o dashboard consegue mostrar risco, prazo, owner, stage, next action e impacto.

### Como Esse Exemplo Alimenta O Dashboard

| Informacao do report | Leitura gerada |
| --- | --- |
| Product = Survey software | O produto entra na contagem de projetos ativos e no Weekly Project Brief. |
| Feature/workstream = Client onboarding flow | O dashboard acompanha essa entrega como um workstream unico, sem duplicar o produto. |
| Baseline end date 2026-07-26 + End date 2026-07-31 | O sistema entende que houve atraso versus plano original. |
| Delay root cause = Environment | Incidents & Delays consegue agrupar a causa do atraso. |
| Depends on = DevOps environment access | Delivery Timeline mostra dependencia e possivel critical path. |
| Stage = QA Review + Progress = 70 | A leitura fica coerente: esta avancado, mas ainda nao entregue. |
| Blocker/risk + Risk impact = High | Executive View e Action Items priorizam o item. |
| Corrective action owner = DevOps + Action target date = 2026-07-24 | A fila de acoes mostra quem precisa agir e ate quando. |
| Decision needed preenchido | Manager Meeting mostra que existe decisao de lideranca/cliente/time. |

### Exemplo De Entrega Adiantada

| Campo | Valor |
| --- | --- |
| Product | Zinergy |
| Feature/workstream | Phase 1 completion and production readiness |
| Baseline end date | 2026-08-07 |
| End date | 2026-07-30 |
| Stage | Release |
| Progress | 90 |
| Health | On Track |
| Summary | Production checklist is nearly complete and the team expects to finish earlier than the original plan. |
| Next action | Confirm production validation and prepare release notes by Friday. |

Resultado esperado: o sistema deve mostrar `Ahead of Schedule`, nao `Postponed`, porque a data atual foi antecipada em relacao ao baseline.

### Exemplo De Workstream Entregue

| Campo | Valor |
| --- | --- |
| Product | ALPHA Sales Platform |
| Feature/workstream | Sync/First Meeting with DEVs |
| Stage | Completed |
| Progress | 100 |
| Health | On Track |
| End date | 2026-07-10 |
| Summary | The handoff was completed and the team has the information required for the next sprint. |
| Win | Engineering and PM aligned on the sprint structure. |
| Next action | No delivery action required; monitor next sprint intake. |

Resultado esperado: quando `Stage = Completed`, o workstream deve ser considerado entregue/delivered.

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
| Schedule delay | Start date, baseline end date, end date, date changes |
| Ahead of Schedule | End date antecipado |
| On Time | End date dentro do prazo |
| Minor/Major Delay | End date atrasado |
| Blocker concentration | Blocker/risk + product |
| Action queue | Next action + corrective action owner + action target date + action status |
| Owner workload | Owner + workstreams |
| Report quality | Campos faltando ou genericos |
| Weekly feedback | Owner + report quality + risks + actions |
| Project brief | Product + stage + health + progress + actions |
| Critical path | Depends on + delay root cause + end date |
| Decision queue | Decision needed + priority + risk impact |

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
