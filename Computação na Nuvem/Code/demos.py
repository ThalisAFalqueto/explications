import boto3
import time

REGIAO = 'us-east-1'

print('Iniciando sessão com a AWS...')
session = boto3.Session(region_name=REGIAO)

s3_client = session.client('s3')  
nome_bucket = 'demo-boto3-fallqz'  # nome único

print('Criando S3 Bucket')
try:
    s3_client.create_bucket(Bucket=nome_bucket)
except Exception as e:
    print(f'Erro no S3: {e}')

dynamo_client = session.client('dynamodb')
nome_tabela = 'TabelaDemo'

print('Criando DynamoDB Table')
try:
    dynamo_client.create_table(
        TableName=nome_tabela,
        KeySchema=[{'AttributeName': 'id', 'KeyType': 'HASH'}],
        AttributeDefinitions=[{'AttributeName': 'id', 'AttributeType': 'S'}],
        BillingMode='PAY_PER_REQUEST'
    )
    time.sleep(10)  # esperar a criação
except Exception as e:
    print(f'Erro no DynamoDB: {e}')

ecs_client = session.client('ecs')
nome_cluster = 'ClusterDemo'

print('Criando Cluster ECS')
try:
    ecs_client.create_cluster(clusterName=nome_cluster)
except Exception as e:
    print(f'Erro no ECS: {e}')

rds_client = session.client('rds')
nome_db = 'banco-demo'

print('Criando Banco RDS')
try:
    rds_client.create_db_instance(
        DBInstanceIdentifier=nome_db,
        AllocatedStorage=20,
        DBInstanceClass='db.t3.micro',  # Classe liberada para estudantes
        Engine='postgres',
        MasterUsername='postgres',
        MasterUserPassword='Senha123',
        PubliclyAccessible=True,  # Permitir que você conecte do seu PC
    )
    time.sleep(120)
except Exception as e:
    print(f'Erro no RDS: {e}')


print('\nLimpeza')

# Nomes dos recursos exatos que criamos no script anterior
nome_bucket = 'demo-boto3-fallqz'
nome_tabela = 'TabelaDemo'
nome_cluster = 'ClusterDemo'
nome_db = 'banco-demo'

s3_client = session.client('s3')
s3_resource = session.resource('s3')

print('Deletando S3 Bucket')
try:
    bucket = s3_resource.Bucket(nome_bucket)
    bucket.objects.all().delete()
    print('Objetos do bucket apagados.')

    s3_client.delete_bucket(Bucket=nome_bucket)
except Exception as e:
    print(f'Erro ao deletar S3: {e}')

dynamo_client = session.client('dynamodb')

print('Deletando DynamoDB Table')
try:
    dynamo_client.delete_table(TableName=nome_tabela)
except Exception as e:
    print(f'Erro ao deletar DynamoDB: {e}')

ecs_client = session.client('ecs')

print('Deletando Cluster ECS')
try:
    ecs_client.delete_cluster(cluster=nome_cluster)
except Exception as e:
    print(f'Erro ao deletar ECS: {e}')

rds_client = session.client('rds')
print('Deletando Banco RDS')
try:
    rds_client.delete_db_instance(
        DBInstanceIdentifier=nome_db,
        SkipFinalSnapshot=True
    )
    time.sleep(60)
except Exception as e:
    print(f'Erro ao deletar RDS: {e}')

print('Finalizado')
