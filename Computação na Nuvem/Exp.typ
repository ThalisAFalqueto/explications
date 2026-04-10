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








