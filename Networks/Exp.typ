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
    How Internet Works
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

= Introdução

Objetivo deste material é me ajudar a entender como a internet funciona, mais especificamente, como os dados trafegam pela rede, e quais são os protocolos envolvidos nesse processo, sejam eles UDP, TCP, HTTP, etc. Desde o início mais simples até onde eu conseguir entender. Para isso, estou com alguns livros:
- "How the Internet Really Works", da Edidora no starch press;
- Não lembro 1
- Não lembro 2

Vamos lá! Inicialmente vou separar em livros, talvez fique mais fácil de entender.

= How the Internet Really Works

Pensando num grafo, a Internet não é completamente conectada, mas tem vários centros ou nós, e conexões diretas ou indiretas entre eles.

Nós são dispositivos, como computadores, roteadores, etc. Conexões são os links físicos ou lógicos que permitem a comunicação entre esses nós.
Todo nó tem um endereço IP, que é como um número de telefone para o dispositivo na rede. Ele é usado para identificar e localizar o dispositivo na Internet.

Nós podem transferir mensagens para outros nós se conectando a mesma rede e usando o endereço IP do destinatário. Nós usamos dispositivos chamados de roteadores para conectar redes diferentes. Roteadores direcionam os pacotes e os conjuntos de dados que fazem a Internet funcionar.

Nós que provêm servicos para uma rede são chamados de servidores. Transmitem, recebem e processam informações. Nós que usam um serviço são chamados de clientes. No hardware de um computador, notebbok, etc, existe 
a placa de rede, que é o dispositivo que conecta o computador à rede. Além disso, existe o MAC Adress (Media Access Control), que é um identificador único atribuído a cada placa de rede. Comparativamente ao CPF, ele identifica o dispositivo. Diferente do IP, que identifica onde você está.

Para se comunicar com outros nós na rede, além do enereço MAC, você precisa de um endereço de rede. Para obtê-lo, seu dispositivo precisa conversar com o roteador. Depois de conectado, a placa de rede do seu dispositivo ganha um endereço através do DHCP (Dynamic Host Configuration Protocol). O DHCP é um protocolo de rede que atribui automaticamente endereços IP e outras informações de configuração de rede para dispositivos em uma rede. Ele facilita a conexão dos dispositivos à rede, garantindo que cada um tenha um endereço IP único e válido.
Parabéns! Agora você é parte da rede.

== Pacotes

Toda vez que dois dispositivos se comunicam, eles trocam dados na forma de pacotes. Protocolos de internet descontroem todos esses dados e colocam eles em alguns pacotes, rastrados por uma tag de endereço que contem origem e destino. Isso é chamado de header (cabeçalho) do pacote. Pacotes são feitos de 0s e 1s, também conhecidos por bits. Eles são a unidade básica de dados que trafegam pela rede.

Pelo ar, esses pacotes são transmitidos usando ondas de rádio. Por fios de cobre, são transmitidos por sinais eléticos, e por fibra ótica, são transmitidos por luz. O meio de transmissão pode variar, mas o formato dos pacotes é o mesmo.

O processo de envio costuma seguir esse tráfico: 

=== img

== Protocolos

