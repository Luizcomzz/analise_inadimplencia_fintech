import pandas as pd
import sqlite3 as sql
caminho = ""

#importação de dados do csv e criação de database
def carregar_dados(caminho):
    return pd.read_csv(caminho, header=0, encoding= "utf-8")

def validar_dados(df):

    print("\nDimensão da base") #verifficar quantos elementos tem nessa tabela linhas e colunas
    print(df.shape)

    print("\nNome das colunas") #organizar os nomes das colunar para ver pesquisa em SQL
    print(df.columns)

    print("\nInformações da base") #só para ver os tipos dos atributos e se possui alguma valor nulo, o que facilita parte do trabalho de datacleaning
    print(df.info())

    print("\nDescrição estatística") #apresentação das medidas resumos, media, mediana, quartis, desvio padrão
    print(df.describe())

    print("\nValores nulos") #contar nulos, dessa vez deixando explicito cada coluna
    print(df.isnull().sum())

    print("\nDuplicados") #contar dados duplicados o que facilita a limpeza
    print(df.duplicated().sum())

    print("\nValores únicos", end ="\n") #descobri os valores semelhantes que tem no banco, ajuda a depois saber quais podem ser agruados em faixas
    print(df.nunique()) 

    print(df.head()) #apresenta as primeiras 5 linhas da tabela para conferiro modelo dos dados

#conectar com o banco de dados
def criar_banco(df, nome_banco):

    conn = sql.connect(nome_banco)

    df.to_sql(
        "contratos",
        conn,
        if_exists="replace",
        index=False
    )

    return conn
    print(conn)

def main():

    print("Programa iniciado")

    df = carregar_dados(
        "dados/case_inadimplencia_dataset.csv"
    )

    validar_dados(df)

    conn = criar_banco(
        df,
        "dados/inadimplencia.db"
    )

    conn.close()

    print("Banco criado com sucesso!")

if __name__ == "__main__":
    main()