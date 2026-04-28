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
    Machine Learning
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

= MLP

MLPs(Multi Layer Perceptrons), ou Deep Forward Networks, ou até Feedforward Networks são um tipo de modelo essencial de Deep Learning.
O objetivo do modelo é aproximar alguma função $f^*$. Por exemplo, para uma classificação, $y = f^*(x)$ mapeia um input $x$ para uma classe $y$. Esse modelo define um mapeamento $f(x; theta)$, onde $theta$ são os parâmetros do modelo. O processo de treinamento é encontrar $theta$ tal que $f(x; theta) approx f^*(x)$ para os dados de treinamento.

Esses modelos são chamados de feedforward
porque a informação flui através da
função que está sendo avaliada, partindo de $x$, passando pelos cálculos intermediários usados ​​para definir $f$ e finalmente chegando à saída $y$. Não existem conexões nas quais as saídas do modelo são retroalimentadas.

As redes feedforward são de extrema importância para os profissionais de aprendizado de máquina.
Elas formam a base de muitas aplicações comerciais importantes.
Por exemplo, as redes convolucionais usadas para reconhecimento de objetos em fotos são um
tipo especializado de rede feedforward. As redes feedforward são um
degrau conceitual no caminho para as redes recorrentes, que impulsionam muitas aplicações de
linguagem natural.


