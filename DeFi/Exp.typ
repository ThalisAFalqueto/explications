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
    DeFi
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


= Whitepaper

== Intro

O comércio na internet depende quase exclusivamente de sistemas de 
pagamento centralizados, sejam eles bancos, fintechs, etc. Todos esses 
sistemas atuam como intermediários, processando transações, guardando o dinheiro
e garantindo a segurança dos pagamentos. No entanto, eles também
introduzem custos adicionais e riscos de censura. 
Por causa da possibilidade de reversão de pagamentos, os comerciantes precisam desconfiar de seus clientes e pedir mais informações do que o necessário para se protegerem de fraudes, o famoso KYC.
Isso, fora a obrigatoriedade de fornecer dados pessoais, pode centralizar grande poder
em quem detêm dados e mand ae desmanda nesses sistemas : os governos. Estes custos e incertezas
do pagamento podem ser evitadas usando moeda física em pessoa, mas não existe mecanismo
para fazer pagamentos sobre um canal de comunicações sem uma terceira parte de confiança.

O que é necessário é um sistema eletrônico de pagamento baseado em provas criptográficas, que permita que duas partes façam transações diretamente entre si sem a necessidade de um intermediário confiável.

== Transações

Para Satoshi, uma moeda eletrônica
é uma cadeia de assinaturas digitais. Cada proprietário transfere a moeda para o próximo, assinando digitalmente um hash da transação anterior e do próximo proprietário, e adicionando isso à ponta da moeda. O destinatário pode verificar a assinatura para verificar a cadeia de propriedade (aqui, ele está descrevendo a arquitetura de funcionamento da própria moeda).

Por exemplo: Quando o P1 passa a moeda a P2, ele "assina" digitalmente. Para fazer isso, ele pega o 
hash da transação anterior (que é a última transação que ele recebeu), o hash do próximo proprietário (P2) e assina ambos usando sua chave privada. Ele então adiciona essa assinatura à ponta da moeda. O destinatário, P2, pode verificar a assinatura de P1 usando a chave pública de P1 para garantir que a transação é válida e que ele é o novo proprietário da moeda.

Porém, apenas essa cadeia de assinatura não resolve o problema principal:
 O que impede que o P1 faça uma cópia da moeda e a envie para P2 e P3 ao mesmo tempo?
No sistema tradicional, é para isso que serve um banco ou Casa da Moeda: eles mantêm um registro de todas as transações e garantem que uma moeda não seja gasta mais de uma vez. No entanto, isso requer confiar em uma terceira parte centralizada.

Para não depender de um terceiro confiável, Satoshi propõe duas coisas: 
- As transações deverão ser anunciadas publicamente;
- Os participantes precisarão de um sistema para concordar com uma única história sobre a ordem em que as transações aconteceram.

A estruturação da solução vem logo abaixo:
=== Blockchain (Servidor de Marca Temporal)

O sistema pega um grupo (ou "bloco") de vários itens que precisam ser registrados (transaçãoes) e os organiza em uma estrutura de dados chamada árvore de Merkle (já explico mais a frente). Com todas essas transações, gera um hash de todo o bloco.
Então, pega esse hash e o publica para todos da rede (Satoshi diz que é como se você publicasse esse código nos classificados de um jornal).
Por fim, cada novo bloco  que é criado inclui o hash do bloco anterior, formando uma cadeia de blocos (blockchain). Isso garante que os blocos estejam ligados em uma ordem específica, e qualquer tentativa de alterar um bloco anterior exigiria recalcular todos os blocos subsequentes, o que é computacionalmente inviável.

Mas como garantir que ninguém pode falsificar os blocos em uma rede aberta? Exigindo que os computadores "queimem" energia e processamento real para criar esses blocos:

=== Prova de Trabalho

Para implementar o servidor de marca temporal, Satoshi propõe um sistema de prova de trabalho (Proof of Work - PoW). A ideia é que para criar um novo bloco, os participantes da rede (chamados de mineradores) precisam resolver um problema matemático complexo que requer uma quantidade significativa de poder computacional. O problema é projetado para ser difícil de resolver, mas fácil de verificar.

O desafio consiste em pegar o bloco de transações, adicionar um número aleatório chamado de nonce, e passar tudo isso pela função de hash (como o SHA-256). O objetivo é encontrar um hash que comece com uma quantidade específica de zeros (balanceado pela quantidade de mineradores). Exemplo:
O nonce é um número aleatório que é adicionado ao hash do bloco anterior.
Ou seja: digamos que o hash do bloco anterior seja $"abc"123$.
O minerador pega esse hash, adiciona um nonce (um valor $in [0, infinity]$) por exemplo, $01$, e passa 
o $("hash_anterior" + "transacoes_bloco_atual" + "nonce")$ pela função de hash. O resultado é um novo hash, e o minerador precisa encontrar um nonce que faça com que esse novo hash comece com uma quantidade específica de zeros (por exemplo, $00"dasfj"$ no caso de um novo hash de dois zeros no começo). Como a função de hash é quase que aleatória, quanto mais zeros você encontrar, mais difícil será encontrar o próximo.

 
Depois que a energia e o esforço da CPU são gastos para encontrar a resposta e o bloco é criado, ele não pode ser alterado sem que todo o trabalho seja refeito. Como os blocos estão encadeados, tentar mudar um bloco antigo exigiria refazer o trabalho daquele bloco e de todos os blocos que vieram depois dele.

A decisão da maioria é sempre representada pela cadeia de blocos mais longa, pois ela é a prova visual de que a maior quantidade de esforço computacional foi investida ali. Se a maioria do poder de CPU for controlada por pessoas honestas, a cadeia honesta crescerá mais rápido que a de qualquer atacante.

Para compensar o fato de que os computadores ficam mais rápidos com o tempo (ou que mais computadores entram na rede), a dificuldade do desafio se ajusta automaticamente (no caso, os $0$ precisam ser encontrados). O objetivo é manter uma média constante de criação de blocos por hora.

== Rede

Se juntarmos tudo discutido até agora, qualquer computador que decide participar dessa rede (chamado de "nó") faz o seguinte ciclo:

- As novas transações que as pessoas estão fazendo pelo mundo são transmitidas para todos os computadores da rede;
- Cada computador (nó) pega essas novas transações que estão soltas e as agrupa dentro de um bloco;
- Em seguida, cada computador começa a gastar sua energia para tentar resolver a Prova de Trabalho para o seu próprio bloco;
- Quando um computador finalmente consegue resolver a Prova de Trabalho, ele avisa a todos os outros e transmite o seu bloco finalizado para a rede;
- Os outros computadores conferem se as transações daquele bloco são válidas (se ninguém tentou fazer gasto duplo) e o aceitam;

Os nós consideram sempre a cadeia mais comprida como a correta e continuaram a tentar
aumentá-la. Se dois nós difundirem versões diferentes do bloco seguinte simultaneamente, alguns
nós poderão receber um ou o outro em primeiro lugar. Nesse caso, processam o primeiro
recebido, mas guardam o outro ramo caso venha a ser maior. O desempate faz-se quando a
próxima prova-de-trabalho for determinada e um ramo ficar maior; os nós que estavam a
processar o outro ramo mudarão para o maior.

== Incentivo

Agora, o que motiva os mineradores a gastar energia e recursos para criar blocos? Satoshi propõe um sistema de incentivos para garantir que os participantes sejam recompensados por seu trabalho. A cada bloco criado, o minerador recebe uma recompensa em forma de nova moeda (no caso do Bitcoin, são $50$ bitcoins por bloco, mas esse valor é reduzido pela metade a cada $210.000$ blocos). Além disso, os mineradores também recebem as taxas de transação associadas às transações incluídas no bloco.

== Recuperação de Espaço em Disco



Se cada computador precisar guardar o histórico completo de todas as transações da história para conseguir validá-las, o tamanho desse arquivo não ficaria gigantesco e inviável com o tempo?

A resposta é não.

=== Árvore de Merkle

uma Árvore de Merkle é essencialmente uma árvore binária construída de baixo para cima, onde as conexões (arestas) entre os vértices (nós) são forjadas por funções criptográficas.

Na camada inferior da estrutura, temos os nós-folha, que são as transações reais em si (Tx0, Tx1, Tx2, Tx3). O sistema aplica a função de hash individualmente em cada uma delas, gerando as impressões digitais base (Hash0, Hash1, Hash2 e Hash3).

Em seguida, o algoritmo agrupa esses vértices adjacentes em pares. Ele concatena o Hash0 com o Hash1 e passa essa dupla pela função de hash novamente, gerando um "nó pai" superior chamado Hash01. Ele faz a mesma coisa agrupando o Hash2 e Hash3 para gerar o nó Hash23.

Esse processo recursivo de emparelhar e aplicar o hash se repete, reduzindo o número de nós pela metade a cada nível que sobe, até sobrar apenas o o Hash Raiz no topo.