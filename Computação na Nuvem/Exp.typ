Por enquanto, sem título mesmo. Só iniciando o repositório...


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

=== imagem do Slide

== Modelos de Infraestrutura

Existem alguns tipos de forma de se hospedar a nuvem:
- Nuvem pública - Operada por um provedor externo e compartilhada entre múltiplos clientes (o cliente não controla o hardware físico). Exemplo: AWS.
- Nuvem privada - Infraestrutura dedicada a uma única organização. O datacenter pode ser na própria empresa ou terceirizado. Exemplo: Bancos, governo, saúde.
- Nuvem híbrida - Meio a meio dos anteriores. Exemplo: banco com dados sensíveis guardados pela própria empresa, nuvem para picos de demanda.
- Nuvem comunitária - Compartilhado com múltiplas organizações. Exemplo: Kaggle pode ser um tipo de nuvem comunitária,  pois é um ambiente virtual compartilhado por uma comunidade específica, que se ajudam com dados, análises, etc.
- Multicloud - Uso simultâneo de múltiplos provedores de nuvem pública. Exemplo: AWS para tal coisa, Azure pra outra e GCP pra outra.

Em geral, existem 3 provedores mais utilizados: AWS (Amazon Web Service), Microsoft Azure e Google Cloud Plataform (GCP).

= Slide 3 - Máquinas virtuais
