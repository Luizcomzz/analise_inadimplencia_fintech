import pandas as pd
import sqlite3 as sql
caminho = ""

#importação de dados do csv e criação de database
def carregar_dados(caminho):
    return pd.read_csv(caminho, header=0, encoding= "utf-8")

def validar_dados(df):

    print("\nDimensão da base")
    print(df.shape)

    print("\nNome das colunas")
    print(df.columns)

    print("\nInformações da base")
    print(df.info())

    print("\nDescrição estatística")
    print(df.describe())

    print("\nValores nulos")
    print(df.isnull().sum())

    print("\nDuplicados")
    print(df.duplicated().sum())

    print(df.head())
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