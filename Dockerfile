# Dockerfile para Coolify
FROM golang:1.21-alpine AS builder

# Instalar dependências necessárias
RUN apk add --no-cache git ca-certificates tzdata

# Definir diretório de trabalho
WORKDIR /app

# Copiar arquivos de dependências
COPY src/go.mod src/go.sum ./

# Baixar dependências
RUN go mod download

# Copiar código fonte
COPY src/ ./

# Build da aplicação
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o quepasa main.go

# Imagem final
FROM alpine:latest

# Instalar dependências de runtime
RUN apk --no-cache add ca-certificates tzdata postgresql-client

# Criar usuário não-root
RUN addgroup -g 1001 -S quepasa && \
    adduser -u 1001 -S quepasa -G quepasa

# Definir diretório de trabalho
WORKDIR /app

# Copiar binário compilado
COPY --from=builder /app/quepasa .

# Copiar arquivos de configuração
COPY --from=builder /app/views ./views
COPY --from=builder /app/assets ./assets

# Definir permissões
RUN chown -R quepasa:quepasa /app
USER quepasa

# Expor porta
EXPOSE 31000

# Variáveis de ambiente padrão
ENV WEBAPIHOST=0.0.0.0
ENV WEBAPIPORT=31000
ENV GOOS=linux

# Comando de inicialização
CMD ["./quepasa"]
