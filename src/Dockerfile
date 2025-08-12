# Dockerfile para Coolify (dentro de src/)
FROM golang:1.21-alpine

# Instalar dependências
RUN apk add --no-cache git ca-certificates tzdata

# Definir diretório de trabalho
WORKDIR /app

# Copiar arquivos de dependências
COPY go.mod go.sum ./

# Baixar dependências
RUN go mod download

# Copiar código fonte
COPY . .

# Build da aplicação
RUN CGO_ENABLED=0 GOOS=linux go build -o quepasa main.go

# Expor porta
EXPOSE 31000

# Variáveis de ambiente
ENV WEBAPIHOST=0.0.0.0
ENV WEBAPIPORT=31000
ENV GOOS=linux

# Comando de inicialização
CMD ["./quepasa"]
