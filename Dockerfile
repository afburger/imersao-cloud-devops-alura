# Estágio 1: Base Image
# Usando uma imagem Python leve baseada em Alpine. É uma boa escolha para imagens pequenas.
FROM python:3.13.5-alpine3.22

# Definir o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copiar o arquivo de dependências primeiro
# Isso aproveita o cache do Docker. Se o requirements.txt não mudar,
# o Docker não reinstalará as dependências em builds futuros.
COPY requirements.txt .
# Instalar as dependências
# --no-cache-dir reduz o tamanho final da imagem
RUN pip install --no-cache-dir -r requirements.txt

# Copiar todo o código da aplicação para o diretório de trabalho
COPY . .

# Expor a porta em que a aplicação será executada
EXPOSE 8000

# Comando para iniciar a aplicação com Uvicorn
# O host 0.0.0.0 permite que a aplicação seja acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]