import os
import sqlite3
import pandas as pd


# ================================================================
# Constantes — caminhos centralizados para fácil manutenção
# ================================================================
RAW_PATH = "dados/raw/case_inadimplencia_dataset.csv"
DB_PATH  = "dados/processed/inadimplencia.db"


def carregar_dados(caminho: str) -> pd.DataFrame:
    """
    Lê o arquivo CSV de contratos e retorna um DataFrame.

    Parâmetros:
        caminho (str): Caminho relativo ou absoluto para o arquivo CSV.

    Retorna:
        pd.DataFrame: DataFrame com os dados carregados.

    Lança:
        FileNotFoundError: Se o arquivo não existir no caminho informado.
    """
    if not os.path.exists(caminho):
        raise FileNotFoundError(f"Arquivo não encontrado: {caminho}")
    return pd.read_csv(caminho, encoding="utf-8")


def explorar_dados(df: pd.DataFrame) -> None:
    """
    Exibe um diagnóstico completo do DataFrame no console.
    Útil para validação rápida da qualidade dos dados na etapa de ingestão.

    Parâmetros:
        df (pd.DataFrame): DataFrame a ser explorado.
    """
    print("\n--- Dimensão da base (linhas x colunas) ---")
    print(df.shape)

    print("\n--- Nome das colunas ---")
    print(df.columns.tolist())

    print("\n--- Tipos e valores nulos por coluna ---")
    print(df.info())

    print("\n--- Estatísticas descritivas ---")
    print(df.describe())

    print("\n--- Contagem de valores nulos por coluna ---")
    print(df.isnull().sum())

    print("\n--- Registros duplicados ---")
    print(df.duplicated().sum())

    print("\n--- Cardinalidade por coluna (valores únicos) ---")
    print(df.nunique())

    print("\n--- Primeiras linhas da base ---")
    print(df.head())


def criar_banco(df: pd.DataFrame, caminho_banco: str) -> None:
    """
    Persiste o DataFrame na tabela 'contratos' de um banco SQLite.
    Usa context manager para garantir que a conexão seja fechada
    mesmo em caso de erro.

    Parâmetros:
        df (pd.DataFrame): DataFrame com os dados a serem persistidos.
        caminho_banco (str): Caminho para o arquivo .db do SQLite.
    """
    with sqlite3.connect(caminho_banco) as conn:
        df.to_sql(
            "contratos",
            conn,
            if_exists="replace",
            index=False
        )


def main() -> None:
    """Orquestra o pipeline de ingestão e persistência dos dados."""
    print("Pipeline iniciado.")

    try:
        df = carregar_dados(RAW_PATH)
        explorar_dados(df)
        criar_banco(df, DB_PATH)
        print(f"\nBanco de dados criado com sucesso em: {DB_PATH}")

    except FileNotFoundError as e:
        print(f"\n[ERRO] {e}")
        print("Verifique se o arquivo CSV está na pasta correta e tente novamente.")


if __name__ == "__main__":
    main()