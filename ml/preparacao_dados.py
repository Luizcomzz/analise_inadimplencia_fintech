import pandas as pd

# Localização da pasta ml
PASTA_ML = Path(__file__).resolve().parent

# Caminho para o CSV
caminho_dados = PASTA_ML.parent / "dados" / "raw" / "case_inadimplencia_dataset.csv"

df = pd.read_csv(caminho_dados, encoding="utf-8")

