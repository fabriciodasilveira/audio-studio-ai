# Use uma imagem base Python leve
FROM python:3.10-slim

# Define o diretório de trabalho
WORKDIR /app

# Instala dependências do sistema necessárias para processamento de áudio (soundfile)
RUN apt-get update && apt-get install -y \
    libsndfile1 \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Copia e instala as dependências do Python
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copia o restante do código fonte
COPY . .

# Cria diretórios necessários para garantir permissões e existência
RUN mkdir -p temp models

# Expõe as portas padrão do Streamlit e FastAPI
EXPOSE 8501 8000

# O comando padrão executa a interface web, mas será substituído no docker-compose
CMD ["streamlit", "run", "app.py", "--server.address=0.0.0.0"]