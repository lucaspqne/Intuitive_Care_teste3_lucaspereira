#Diretórios de entrada e saída do arquivo csv.
caminho_original = r'C:\Users\Lucas\Desktop\intuitive_care\teste3\RelatorioORIGINAL.csv'
caminho_saida = r'C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\RelatorioCOPIA.csv'

#Abrir arquivo e remover as aspas
with open(caminho_original, 'r') as file:
    relatorio = file.read()
    relatorio = relatorio.replace('\"', '')
    print("CSV modificado com sucesso!")

#Escrever em cima do arquivo modificado
with open (caminho_saida, 'w') as file_out:
    file_out.write(relatorio)
    print("CSV salvo com sucesso!")
    