import numpy as np
from tensorflow.keras.datasets import mnist


class NeuralNetwork:
    def __init__(self, dimensions: list):
        self.dimensions = dimensions
        self.layers = len(dimensions) - 1  # não precisamos de peso pra primeira camada
        self.params = {}
        for layer in range(self.layers):   # cria as matrizes de beso e bias iniciais
            self.params['W' + str(layer)] = np.random.randn(self.dimensions[layer + 1], self.dimensions[layer])  * 0.01
            self.params['b' + str(layer)] = np.zeros((self.dimensions[layer + 1], 1))

    def relu(self, Z):
        return np.maximum(0, Z)

    def softmax(self, Z):
        '''
        Calcula a Softmax garantindo estabilidade numérica.
        Z: matriz de formato (classes, exemplos) -> ex: (10, m) para MNIST
        '''
        # keepdims=True garante que a matriz continue com as colunas certas para o broadcasting
        Z_max = np.max(Z, axis=0, keepdims=True)
        Z_estavel = Z - Z_max  # pra n explodir em algum momento

        exponenciais = np.exp(Z_estavel)
        soma_exponenciais = np.sum(exponenciais, axis=0, keepdims=True)
        A = exponenciais / soma_exponenciais

        return A

    def forward(self, X):
        self.cache = []
        # self.layers - 1 pois a última ativação precisa ser diferente. Relu não faz sentido pra calcular probabilidade
        for layer in range(self.layers - 1):
            X_prev = X
            W = self.params['W' + str(layer)]
            b = self.params['b' + str(layer)]

            dot = W @ X + b
            Z = self.relu(dot)
            X = Z
            self.cache.append([X_prev, W, b, dot])

        # softmax pra última camada
        last_layer = self.layers - 1
        last_dot = self.params['W' + str(last_layer)] @ Z + self.params['b' + str(last_layer)]
        last_Z = self.softmax(last_dot)
        self.cache.append([Z, self.params['W' + str(last_layer)], self.params['b' + str(last_layer)], last_dot])

        return last_Z





print('Carregando MNIST...')
(X_treino_orig, Y_treino_orig), (X_teste_orig, Y_teste_orig) = mnist.load_data()

X_teste = X_teste_orig.reshape(X_teste_orig.shape[0], -1).T

X_teste = X_teste / 255.0

Y_teste = np.zeros((10, Y_teste_orig.shape[0]))
for i in range(Y_teste_orig.shape[0]):
    Y_teste[Y_teste_orig[i], i] = 1

print(f'Formato final de X_teste: {X_teste.shape} -> (pixels, imagens)')
print(f'Formato final de Y_teste: {Y_teste.shape} -> (classes, imagens)')

dimensoes = [784, 128, 64, 10]
rede = NeuralNetwork(dimensoes)

print('Rodando')
previsoes_porcentagens = rede.forward(X_teste)

respostas_da_rede = np.argmax(previsoes_porcentagens, axis=0)
respostas_corretas = np.argmax(Y_teste, axis=0)

acuracia = np.mean(respostas_da_rede == respostas_corretas)
print(f'Acurácia: {acuracia * 100:.2f}%')
