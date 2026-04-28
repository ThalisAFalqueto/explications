#import "@preview/ctheorems:1.1.3": *
#import "@preview/lovelace:0.3.0": *
#show: thmrules.with(qed-symbol: $square$)

#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *
#show: codly-init.with()
#codly(languages: codly-languages, stroke: 1pt + luma(100))

#import "@preview/tablex:0.0.9": tablex, rowspanx, colspanx, cellx

#set page(width: 21cm, height: 30cm, margin: 1.5cm)

#set par(
  justify: true
)

#set figure(supplement: "Figura")

#set heading(numbering: "1.1.1")

#let theorem = thmbox("theorem", "Teorema")
#let corollary = thmplain(
  "corollary",
  "Corolário",
  base: "theorem",
  titlefmt: strong
)
#let definition = thmbox("definition", "Definição", inset: (x: 1.2em, top: 1em))
#let example = thmplain("example", "Exemplo").with(numbering: none)
#let proof = thmproof("proof", "Demonstração")

#set math.equation(
  numbering: "(1)",
  supplement: none,
)
#show ref: it => {
  // provide custom reference for equations
  if it.element != none and it.element.func() == math.equation {
    // optional: wrap inside link, so whole label is linked
    link(it.target)[(#it)]
  } else {
    it
  }
}

#set text(
  font: "Atkinson Hyperlegible",
  size: 12pt,
)

#show heading: it => {
  if it.level == 1 {
    [
      #block(
        width: 100%,
        height: 1cm,
        text(
          size: 1.5em,
          weight: "bold",
          it.body
        )
      )
    ]
  } else {
    it
  }
}


// ============================ PRIMEIRA PÁGINA =============================
#align(center + top)[
  FGV EMAp

  Thalis Ambrosim Falqueto
]

#align(horizon + center)[
  #text(17pt)[
    Computação na nuvem
  ]
  
  #text(14pt)[
    Explications
  ]
]

#align(bottom + center)[
  Rio de Janeiro

  2026
]

#pagebreak()

// ============================ PÁGINAS POSTERIORES =========================
#outline(title: "Conteúdo")

#pagebreak()

= Slide 1 - Introdução

Imagine que você tem um projeto, que, em algoritmo, já está otimizado. Ou seja, ele já está com as alocações mais inteligentes, e com o algoritmo de menor complexidade que resolve o problema. Mas, agora, você quer lançar essa solução de problema como um produto, e, sonha com um uso de $100.000$ usuários ao mesmo tempo, para você ficar bem rico. Será que, mesmo com o melhor script, seu PC da xuxa aguentaria essa quantidade de requisições? 

É claro que não!  


== Dimensionamento

Digamos que você estima uma quantidade média de requisições no seu site de $100.000$, mas, que em horários de pico ou em dias específicos, esse sistema possa acabar precisando de suporte para mais de $1.000.000$ de requisições. Com isso, você se pergunta:

"Meu sistema deveria se precaver de um milhão de requisições com um custo 10x e desperdício de desempenho em quantidades de requisições menores ou eu deveria me preocupar somente com o uso normal diário, mesmo que perca todo o site (e assim os clientes) em eventos de pico?"

= Slide 2 - Fundamentos

A solução: Computação na nuvem. A definição de computação na nuvem é desenvolvida em cima de 
5 características essenciais:
- Autoatendimento sob demanda - Você mesmo provisiona seus recursos, sem interação humana;
- Amplo acesso sobre à rede - A infraestrutura e serviços podem ser acessados pela internet usando qualquer dispositivo padrão;
- Agrupamento de recursos - A empresa que fornece o serviço agrupa seus servidores físicos para atender a vários clientes de forma dinâmica e invisível;
- Elasticidade rápida - Garantia de que a capacidade do seu sistema pode expandir automaticamente nos picos de acesso e reduzir quando a demanda cair (solução do problema antes explicado);
- Serviço medido - O seu consumo de recursos é monitorado constantemente, permitindo que você pague apenas pelo que utilizou.

== Modelos de serviço

Existem alguns tipos de infraestrutura que você pode ter (que varia de acordo com 
o nível de controle que você terá):
- IaaS (Infraestrutura as a Service) - O provedor fornece o servidor bruto (processamento, rede, armazenamento). Você tem controle total, mas precisa gerenciar o sistema operacional e a aplicação. Exemplo: Amazon EC2 (explicaremos depois);
- PaaS (Plataforma as a Service) - O provedor gerencia toda a infraestrutura e o sistema operacional. Foca-se apenas em escrever a lógica de negócio do produto. Exemplo: ainda não sei;
- SaaS (Software as a Service) - Produto $100%$ pronto e gerenciado pelo provedor, pronto para o usuário final. Exemplo: Netflix, Spotify;

#figure(
  caption: [Imagem de tipos de infraestrutura. Em azul, o que é feito por você, e, em branco, o que é feito pelo prestador de serviço],
  image(width: 95%, "images/aas.png")
)


== Modelos de Infraestrutura

Existem alguns tipos de forma de se hospedar a nuvem:
- Nuvem pública - Operada por um provedor externo e compartilhada entre múltiplos clientes (o cliente não controla o hardware físico). Exemplo: AWS.
- Nuvem privada - Infraestrutura dedicada a uma única organização. O datacenter pode ser na própria empresa ou terceirizado. Exemplo: Bancos, governo, saúde.
- Nuvem híbrida - Meio a meio dos anteriores. Exemplo: banco com dados sensíveis guardados pela própria empresa, nuvem para picos de demanda.
- Nuvem comunitária - Compartilhado com múltiplas organizações. Exemplo: Kaggle pode ser um tipo de nuvem comunitária,  pois é um ambiente virtual compartilhado por uma comunidade específica, que se ajudam com dados, análises, etc.
- Multicloud - Uso simultâneo de múltiplos provedores de nuvem pública. Exemplo: AWS para tal coisa, Azure pra outra e GCP pra outra.

Em geral, existem 3 provedores mais utilizados: AWS (Amazon Web Service), Microsoft Azure e Google Cloud Plataform (GCP).

= Slide 3 - Máquinas virtuais

Um servidor físico (um PC) possui recursos físicos (CPU, memória, disco de rede). Normalmente ele executa um único sistema operacional, e essa abordagem pode deixar recursos ociosos, como explicado no problema de dimensionamento. Por isso a tecnologia de Máquinas Virtuais (VMs), resolve isso, pois permite dividir e aproveitar melhor esse servidor.

Virtualização é a técnica que permite executar
múltiplos ambientes isolados sobre o mesmo
hardware físico, por meio de um software
chamado hipervisor. Assim, pode-se aproveitar melhor os recursos, pois componentes podem
ser executados em ambientes isolados, cada um com uma proporção diferente de acordo com a demanda,
além de criação e destruição de processos automatizada.


#figure(
  caption: [Imagem de como funciona o particionamento de uma Máquina virtual, com ajuda do software hipervisor.],
  image(width: 80%, "images/vms.png")
)

== EC2

O *EC2* é o serviço de computação virtual da AWS (lançado em 2006). É um serviço IaaS, ou seja, a AWS gerencia  o hardware físico, o hipervisor e a rede subjacente, enquanto o usuário
gerencia sistema operacional, middleware e a aplicação. Uma instância do EC2 é uma máquina virtual que roda dentro dos servidores físicos da AWS.

=== Armazenamento

Existem dois tipos de armazenamento para serviços do tipo EC2:
- Instance Store - Armazenamento apenas da própria instância, ou seja, da própria máquina virtual. Possui alta performance, pois é acesso local. Porém, se a instância cair, parar ou hibernar, perde os dados;
- EBS (Elastic Block Store) - Funciona com o um disco persistente. Os dados ficam salvos de forma independente e não são perdidos se você desligar ou reiniciar a máquina. Podem ser conectados/enviados a outras instâncias facilmente.

=== Características de Instância

Essas instâncias, além de armazenamento, seguem uma nomenclatura padronizada, da forma:

$
  "família" + "geração" + "atributos" . "tamanho"
$

Exemplo: t3.medium, c6i.xlarge, etc. Explicação da nomenclatura:
- família - Varia de acordo com a necessidade de uso:#figure(
  caption: [Explicação de cada variação de família e suas principais utilidades.],
  image(width: 100%, "images/familiasec2.png")
)
- geração - Indica a versão do hardware. Quanto maior for, mais moderno é, e, geralmente, gerações mais recentes oferecem maior custo-benefício;
- atributos - São opcionais e podem ser combinados:#figure(
  caption: [Explicação de cada variação de atributo e seus signficados.],
  image(width: 70%, "images/atributosec2.png")
)
- tamanho - Define quantidade de vCPU e memória.#figure(
  caption: [Explicação de cada variação de tamanho e suas quantidades de vCPU e memória respectivas.],
  image(width: 70%, "images/tamanhoec2.png")
)

Explicando a imagem, uma vCPU é uma fatia de processamento de um servidor físico
real alocada exclusivamente para a VM. Esses processadores possuem núcleos físicos capazes de executar instruções
simultaneamente de forma independente, através de uma técnica chamada hyperthreading cada núcleo físico expõe duas
threads de execução ao sistema operacional. Na AWS cada vCPU corresponde à uma thread, portanto, uma instância com 2
threads tem duas linhas de processamento independentes.

=== Ciclo de Vida

Uma instância EC2 possui quatro estados principais que definem o seu funcionamento e sua cobrança:
- Pendente (pending) - A máquina está sendo provisionado e não gera custos;
- Running (rodando) - A máquina está ligada, acessível e a cobrança por processamento está ativa;
- Stopped (parada) - A máquina está desligada, é por isso só é cobrado o que não é completamente dependente da instância, no caso, o armazenamento. Você continua pagando sobre o EBS;
- Terminated (excluída) - Excluíram a máquina, fim.

Quando você desliga (stopped) a máquina e liga novamente, o endereço IP da máquina pode mudar (pois a instância pode mudar de host físico), fazendo com que seja necessário um IP genérico e fixo para 
a mesma instância, chamado de Elastic IP. Além disso, o volume EBS raiz pode ou não ser excluído ao terminar a instância, e essa ação é definida pela flag `Delete on termination`.

=== Precificações da Instância

Existem quatro modelos de precificação para as instâncias do EC2:
- On-demand - Paga por segundo de uso, sem compromisso, ideal para testes, picos, etc.;
- Reserved instances - Firma contratos de mesma instância de 1 a 3 anos, conseguindo assim grande porcentagem de desconto, ideal para um sistema de público estável e previsível;
- Saving plans - Alternativa mais flexível do que a de cima, se comprometendo com um gasto mínimo por hora, também recebendo desconto e podendo mudar a família da instância;
- Spot - Capacidade ociosa da AWS leiloada com desconto. O problema é que a AWS pode desligá-las com um aviso prévio de apenas 2 minutos se precisar da capacidade de volta, então só devem ser usadas para tarefas que podem ser interrompidas sem quebrar o sistema.

Lembrando: então, uma instância do EC2 têm cobrança tanto pela característica da instância escolhida, quanto a forma de uso dessa instância, quanto o armazenamento utilizado para a instância.

== AMI 

A Amazon Machine Image é um template que define o estado inicial de grande parte das coisas que vão no disco de uma instância, ou seja, sistema operacional, pacotes, configurações, etc.
Existem três tipos:
- Públicas - Mantidas pela AWS ou pela comunidade, ou seja, um template de instância genérico;
- Customizadas -Criadas pelo próprio usuário a partir da configuração de uma instância própria;
- AWS Marketplace - Aqui, pode-se comprar (ou vender) AMIs comerciais que já vêm com softwares pagos e licenciados instalados de fábrica. Útil se sua empresa precisa de uma (ou várias) isntância(s) pré formatadas com serviços pagos que você já precisa;

Ou seja, a AMI é utilizada como uma "golden image", provendo um estado configurado da sua
aplicação para levantar rapidamente instâncias da sua aplicação. Alguma AMI é sempre obrigatória.

= Slide 3 - Bancos Gerenciados

É possível que você execute um banco de dados em alguma instância da EC2 de sua escolha, mas, assim como todo banco de dados, você terá certo trabalho para instalar, configurar e atualizar o SGBD, além de ter que administrar agendamento e execução de backups, segurança, monitoramento de performance, re-particionamento em caso de crescimento, etc. A esse ponto, talvez seja melhor só usar um propriamente gerenciado pela AWS.

Com um banco gerenciado, a AWS assume a responsabilidade por:
- Backups automáticos com retenção configurável (até 35 dias no RDS);
- Atualizações automaticamente na janela de manutenção escolhida pelo usuário;
- Alta disponibilidade com Multi-AZ e failover (explicado abaixo);
- Escalabilidade de processamento e armazenamento via API ou interface da AWS;
- Métricas integradas ao CloudWatch sem configuração adicional.

A AWS oferece uma família ampla de serviços de banco de dados. A seguir os
principais:

=== imagem slide

== Amazon RDS

O Amazon RDS (Relationa Database Service) é um serviço gerenciado para execução de SGBDs na nuvem.
O usuário acessa o banco de forma tradicional, com host, porta, drivers, ORMs. e todo controle acontece através da API ou interface da AWS.
Suporta: MySQL, PostgreSQL, MariaDB, Oracle, Microsoft SQL Server e Amazon Aurora.

Assim como no EC2, o RDS também usa classes de instâncias, como db.t3.micro,
db.m6i.large, db.r6i.large, etc. O EBS também pode ser associado a essa instância, e, além disso, a AWS fornece mecanismos para expandir o volume de armazenamento automaticamente ao atingir
um limite pré-determinado.

=== Backups

Os backups automáticos no Amazon RDS funcionam da seguinte forma: A AWS tira uma "foto" (snapshot) diária de todo o volume do seu banco de dados e também guarda o registro contínuo de logs (tudo que aconteceu no banco) que acontece nele.
Com isso, consegue permitir a recuperação em um ponto no tempo (Point-in-Time Recovery). Se alguém apagar uma tabela importante do seu sistema por acidente às 14h05, você pode restaurar o banco de dados exatamente para como ele estava às 14h04.
 A nuvem permite que você configure a retenção desses dados por um período de 1 a 35 dias.

=== Multi-AZ

Ao ser habilitado, mantém uma réplica standby em uma segunda zona. A replicação é síncrona: uma nova linha deve ser confirmada nos dois bancos antes de retornar sucesso.

Em caso de falha (hardware, manutenção): desvio automático em ~60
segundos sem alteração de endpoint (o DNS é atualizado automaticamente) para o banco de réplica. Além disso, os backups são feitos no standby, sem impacto de Input/Output no
banco primário.

Ainda, em uma versão recente do Multi-AZ com dois standbys as réplicas
podem ser utilizadas como leitura (ainda não sei se podemos ter quantos standbys quisermos). Isso implica uma diferença no Read Replicas.

=== Read Replicas (escalabilidade de leitura)

São instâncias somente leitura sincronizadas com o primary de forma assíncrona, com a função de distribuir carga de leitura em produtos com muito mais leituras do que
escritas. Têm até 5 réplicas para MySQL, MariaDB e PostgreSQL.

A aplicação (teu código) precisa direcionar queries de leitura, para os endpoints das réplicas, ou seja, você tem que configurar que query é enviada pra réplica e qual não.
Réplicas podem estar em outra região e, além disso, podem ser promovidas a primary independente (útil para migrações ou disaster
recovery entre regiões), ou seja, você pode desconectar uma réplica do sistema de cópias e transformá-la em um banco de dados principal e independente, que passa a aceitar leitura e gravação.

=== imagem slide

Basicamente, o Multi-AZ pode cobrir parte dos problemas que o Read Replicas cobre, e vice-versa.

== Amazon Aurora

O RDS é bom, mas tem alguns problemas:

- Discos Isolados: cada máquina virtual tem o seu próprio disco (volume EBS) separado;
- Replicação "pesada": Para manter as Read Replicas atualizadas, o banco principal precisa enviar pesados arquivos de registro (logs) constantemente pela rede, o que pode gerar atrasos.
- Lentidão na falha: Se o servidor principal cair, a máquina reserva precisa processar todos esses logs pendentes antes de conseguir aceitar novas conexões. É por isso que o failover do RDS demora cerca de $60$ segundos.

O Amazon Aurora resolver esse problema, da forma:

-  Para de usar o EBS e usa uma rede distribuída proprietária da AWS, e assim consegue salvar os dados 6 vezes em 3 data centers diferentes, garantindo segurança extrema mesmo com apenas uma máquina ligada.
- Em vez de enviar arquivos pesados pela rede para atualizar as cópias, o Aurora envia apenas registros rápidos de mudanças (logs). A própria camada de armazenamento recebe isso e reconstrói as páginas de dados sozinha, o que elimina gargalos de lentidão (não entendi isso e nem acho que seja muito importante entender).

Essas incríveis vantagens que eu não entendi completamente trazem consequências práticas:

=== imagem slide

Quando compensa:
- Produto de produção com leitura intensa e necessidade de alta disponibilidade.
- Crescimento orgânico do volume sem a necessidade de gerenciar storage.
- Failover rápido crítico para a aplicação.
Quando não compensa:
- Desenvolvimento e testes.
- Aplicação requer extensões específicas ainda não suportadas pelo Aurora.

== DynamoDB

O Amazon DynamoDB nasceu para resolver um problema real da própria Amazon: em 2004, durante picos de vendas (como a Black Friday), os bancos de dados relacionais tradicionais simplesmente não aguentavam o tráfego massivo. A solução foi criar o DynamoDB, que é um banco de dados NoSQL e totalmente serverless. Isso significa que não há servidores virtuais para você gerenciar, atualizar ou fazer manutenção.

Diferença de servidor entre DynamoDB e RDS:

- Amazon RDS (Gerenciado mas com servidor): Nele, o servidor ainda existe de forma visível para você. Você precisa escolher o tamanho da máquina virtual (como aquelas famílias db.t3 ou db.m que vimos antes) e pagar por hora enquanto ela estiver ligada. Ele é "gerenciado" porque a AWS instala o banco, aplica atualizações e faz os backups para você, mas você ainda dimensiona o servidor.
- Amazon DynamoDB (Serverless): Aqui, a infraestrutura desaparece completamente. Você não escolhe máquina, quantidade de processador (vCPU) ou memória, simplesmente cria uma tabela e a AWS aloca os recursos magicamente nos bastidores. Em vez de pagar por um servidor ligado, você paga apenas pelo volume de requisições de leitura e escrita que a sua tabela receber.

=== Características

- Suporta dois modelos de dados - chave-valor e documento (JSON).
- Proposta de valor central - latência de dígito único em milissegundos para qualquer escala
  - AWS faz 3 cópias automáticas dos seus dados em data centers diferentes. 
  - Garantido por SLA 99,9%: A AWS garante que o serviço ficará indisponível por, no máximo, cerca de 8,7 horas durante um ano inteiro.

==== Estrutura de dados

- Tabela - container de dados;
- Item - Unidade (linha) de dados dentro de uma tabela;
- Atributo - Par chave-valor dentro de um item;

Único requisito: todos os itens devem conter os atributos que compõem a chave primária da tabela.

=== Funcionamento

Uma partição é uma fatia do espaço total de dados de uma tabela, gerenciada pela AWS, que, tem armazenamento de 10 GB. Ao atingir o limite de armazenamento, é dividido em duas automaticamente e seus itens são redistribuídos. Cada partição (ou tabela, não sei) aguenta até $3.000$ leituras e $1.000$ escritas por segundo. 

Para organizar e encontrar seus dados rapidamente dentro dessas partições, o DynamoDB usa o conceito de chaves:

- Partition Key (chave de partição): É obrigatória;
- Sort Key (chave de ordenação): É opcional e forma uma chave composta junto com a primeira;

Uma função de hash é aplicada sobre o valor da Partition Key para determinar em qual partição física o item será armazenado.

=== imagem slide

Assim, todos os itens com a mesma Partition Key são levados para a
mesma partição, ou seja, latência rápida e constante.

Possível problema: Se você não definiu sua partition key de forma consistente e otimizada para o particionamento, de nada vai adiantar o hash. Exemplos de pks ruins:
- Baixa cardinalidade - a PK tem poucos valores distintos;
- Distribuição desigual de acesso - a natureza da aplicação lê/escreve com maior frequência um subconjunto de entradas;
- Temporal hotspot - usar data como PK.

=== Modelos de cobrança

- Provisionado - Você define um limite máximo de capacidade antecipadamente. O custo é mais barato e previsível (ideal para sistemas com tráfego estável), mas se houver um pico inesperado acima do seu limite, o banco rejeita as conexões excedente;

- On-Demand: Você não configura nenhum limite. O banco escala automaticamente e absorve qualquer volume de tráfego instantaneamente. O custo por requisição é mais alto, mas é a opção segura para tráfegos imprevisíveis;

= Slide 5 - Conteinirização

Uma máquina virtual é pesada, pois precisa instalar e rodar um sistema operacional inteiro só pra ela.
Já a conteinirização é muito mais eficiente, pois é uma virtualização que empacota apenas a sua aplicação 
e as dependências em um ambiente isolado (o contâiner), compartilhando o mesmo ambiente virtual.

== Funcionamento

Funciona em três passos:

- Dockerfile - Script de receita de como preparar sua aplicação (quais arquivos copiar, bibliotecas instalar, etc.);
- Imagem - Pacote fechado e imutável gerado a partir do Dockerfile;
- Container - Instância em execução da imagem;

=== imagem slide

=== Dockerfile

Dockerfile define uma sequência de comandos executados sequencialmente, e comandos do tipo RUN, COPY e ADD produzem uma nova camada (layer) na
imagem, e camadas são utilizadas como cache pelo compilador. No caso do cache, quando você muda a terceira camada, como cada camada é feita em ordem de dependência, ele não precisa re-compilar as camadas 1 e 2, apenas da três para frente. Com isso, reduz drasticamente o tempo de compilação da imagem.

O arquivo segue uma ordem lógica:
- Imagem base: Escolhe um ponto de partida (por exemplo, começar com um sistema já com o Python instalado);
- Dependências: Comandos para instalar as bibliotecas extras que sua aplicação vai precisar para rodar;
- Cópia de arquivos: O comando que transfere os arquivos do seu código-fonte para dentro da imagem;
- Exposição de porta: Define qual porta (como a 80) o container vai usar para se comunicar com a internet;
- Script de inicialização: O comando final que vai efetivamente "ligar" a sua aplicação quando o container ganhar vida;


== Vantagens
Consequentemente, os contâiners consomem menos recursos do sistema operacional, já que não emulam um sistema operacional completo. Pelo mesmo motivo, exigem um tempo menor de inicialização e possibilitam o compartilhamento de recursos.

Outros benefícios:

- Portabilidade – Independe da distribuição Linux (hospedeira).
- Consistência – O ambiente de execução é criado sempre da mesma forma.
- Automação - Possibilita que o processo de implantação seja executado semintervenção humana.
- Escalabilidade - Combinado com outras soluções, possibilita que novas instâncias sejam criadas a fim de atender um aumento de demanda pelo serviço.
- Isolamento - Falhas e vulnerabilidades em um container não afeta os demais containers do sistema.
- Gerenciamento - A padronização da interface do container viabiliza a utilização de ferramentas de orquestração.
- Depurabilidade - Um ambiente de produção pode ser emulado por um desenvolvedor com o objetivo de investigar defeitos dependentes de ambiente.

== Docker Compose

Ferramenta que permite executar múltiplos containers interligados em um único comando, útil para descrever a configuração e o relacionamento entre os containers de um sistema, facilitando o compartilhamento e versionamento da configuração.

= Slide 6 - Orquestração de Containers

O Docker é excelente para empacotar e rodar a aplicação no computador do desenvolvedor, mas não gerencia sistemas complexos em produção. Se um container falhar de madrugada ou se o tráfego aumentar repentinamente, precisamos de uma ferramenta para reiniciar o sistema ou criar novas cópias automaticamente. Um orquestrador de containers automatiza essas responsabilidades.

== ECS

O Amazon ECS é o orquestrador de containers da AWS (traduzido como Elastic Container Service). A AWS gerencia o plano de controle: agendamento de tarefas, registro de estado e
integrações, e o usuário gerencia as definições de containers e a configuração dos serviços.

=== Integrações nativas

Ele vem com algumas integrações nativas:

- ECR (Elastic Container Registry) - Guarda as Imagens Docker da sua aplicação para que o ECS possa puxá-las e rodar;
- ALB (Application Load Balancer): Recebe as requisições dos usuários na internet e distribui o tráfego de forma equilibrada entre todos os containers que estão rodando, garantindo que nenhum fique sobrecarregado;
- CloudWatch - O ECS envia automaticamente os logs e métricas como uso de CPU e memória dos containers. Se o sistema der erro, você lê os logs no CloudWatch em vez de ter que acessar a máquina do container.
- IAM (Identity and Access Management) - É o controle de segurança. Ele permite dar permissões exatas para cada container individualmente. Por exemplo, você pode criar uma regra dizendo que o container do seu site pode ler imagens no armazenamento, mas não pode apagar nada.

=== Organização

O ECS se organiza de duas formas:
- Cluster - Agrupamento lógico onde os containers vão rodar. Se você optar pelo modo de execução Fargate (que é serverless), os servidores físicos e máquinas virtuais ficam totalmente invisíveis para você, tirando o peso do gerenciamento da infraestrutura;
- Task Definition (Definição de Tarefa) - Receita do container para a produção. Nela você especifica qual imagem Docker usar, quanta memória e processador (vCPU) alocar e quais portas liberar para acesso. Toda vez que você altera essa receita, o ECS gera uma nova versão numerada (revisão) para manter o histórico organizado;

a Task Definition dita o que vai rodar, e o Cluster é onde isso vai rodar (eu acho).

Agora, temos duas coisas menores, que parecem derivar dessas outras duas coisas de cima:
- Task (Tarefa) - Instância em execução de uma tarefa;
- Service (Serviço): Rrecurso que pode ser criado em um cluster para definir características de execução de tarefas, definindo quantidade de tarefas de mesmo tipo, reiniciando tarefas com falha, etc.

Aparentemente, o Service trabalha dentro do Cluster garantindo que suas Tasks fiquem sempre ativas, obedecendo as regras da sua Task Definition.

Dentro da Task Definition, a AWS separa a segurança em duas permissões diferentes:

- Task Execution Role - Dá autorização para o próprio ECS conseguir baixar a sua Imagem do repositório (ECR) e enviar os logs do sistema para o CloudWatch;
- Task Role - É a permissão da sua aplicação, define o que o seu código pode fazer lá dentro, como acessar um banco de dados ou ler um arquivo em um bucket do S3.

=== Modos de execução

Ele suporta dois modos de execução:

- Modo EC2 - O usuário provisiona e gerencia os servidores virtuais (instâncias EC2) que compõem o seu cluster. A vantagem é ter acesso total à máquina subjacente (como acesso SSH), mas a cobrança é feita pelas instâncias que estão alocadas e ligadas, independentemente do número de tarefas que estão rodando nelas;
- Modo Fargate: É o modelo serverless (sem servidor). Aqui, a infraestrutura de servidores fica totalmente invisível e você não precisa gerenciar instâncias EC2. A AWS cuida de toda a alocação de recursos automaticamente e você paga apenas pelo que as suas tarefas consumirem.

=== Estratégias de deploy

Beleza, mas como atualizar o seu sistema sem tirá-lo do ar? O ECS gerencia isso de duas formas principais através do Service:

- Rolling Update (Estratégia padrão) - O ECS substitui os containers antigos pelos novos gradualmente. Você define uma porcentagem mínima e máxima de tarefas rodando, garantindo que a capacidade do seu sistema se mantenha estável para os usuários durante toda a transição;
- Blue/Green (Usando o AWS CodeDeploy) - É uma estratégia mais avançada e segura. Ele cria um ambiente totalmente novo e paralelo (o Verde) rodando ao lado do seu ambiente atual (o Azul). Você decide como transferir os clientes para o ambiente novo: tudo de uma vez (All-at-once), um pouquinho, pausa e depois o resto (Canary), ou um pouquinho por vez (Linear). A maior vantagem é rollback imediato: se a versão nova der problema, você volta o tráfego instantaneamente para o ambiente Azul, que continua intacto esperando.

=== Balanceador de carga

O ALB (Application Load Balancer) opera na camada de aplicação, e por isso consegue inspecionar o conteúdo da requisição (HTTP/HTTPS) e distribuir o tráfego de forma inteligente, roteando com base na URL, no host ou em cabeçalhos, da forma:
- O cliente acessa a sua aplicação através do ALB;
- O ALB encaminha a requisição para um Target Group, que funciona como uma lista dinâmica de quais tarefas (containers) estão saudáveis e disponíveis para receber acessos;
- O Target Group, por fim, entrega a requisição diretamente para a rede do seu container, garantindo balanceamento das requisições entre containers.

=== Escalabilidade automática
 
O Auto Scalling aumenta ou diminui sozinho a quantidade de containers rodando no seu sistema, obedecendo os limites de mínimo e máximo configurados;
Para saber a hora exata de criar ou destruir containers, ele usa políticas. As duas principais são:

- Target Tracking (Rastreamento de Alvo) - O usuário define um alvo, por exemplo, "manter o uso médio de CPU em 60%". Se o tráfego aumentar e a CPU passar desse alvo, a AWS cria novos containers. Se o tráfego cair, ela destrói os containers excedentes para economizar dinheiro;
- Step Scaling - Permite criar regras "em degraus" usando alarmes. Por exemplo: adicione 2 containers se a CPU passar de 70%, e adicione 5 containers se passar de 90%.

O serviço também aplica um tempo de pausa (Cooldown) entre essas ações para evitar um "efeito cascata", impedindo que o sistema fique criando e destruindo máquinas de forma descontrolada a cada segundo. Dá pra ver algumas métricas de CPU, memória e requisições e colocar essas métricas como gatilho para ativar o scaling.

=== Monitoramento

O ECS se integra nativamente ao CloudWatch da AWS. Nele, você tem duas ferramentas principais de apoio:

- Container Insights - Coleta métricas detalhadas e visuais do seu cluster, dos serviços e de cada container individualmente;
- CloudWatch Alarms: Fica vigiando essas métricas para acionar automaticamente as regras do Auto Scaling (como criar mais máquinas em um pico) ou para disparar alertas operacionais (como enviar um e-mail).

= Slide 7 - Comunicação através de mensagens

