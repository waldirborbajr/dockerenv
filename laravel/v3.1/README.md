# Ambiente Docker para Desenvolvimento Laravel

Este ambiente Docker vai automaticamente:
1. ✅ Instalar as dependências do Composer
2. ✅ Configurar o arquivo .env (se necessário)
3. ✅ Gerar a APP_KEY
4. ✅ Configurar permissões
5. ✅ Iniciar o servidor Laravel

## 🚀 Primeira execução:

# 1. Coloque os arquivos Docker na pasta do projeto

```bash
cd $HOME/prj/megaapi
```

# 2. Configure o Firebird no docker-compose.yml
# Edite as variáveis DB_HOST, DB_DATABASE, DB_USERNAME, DB_PASSWORD

# 3. Construa a imagem

```sh
make build
```

# 4. Inicie o ambiente (vai instalar tudo automaticamente)

```sh
make up
```

# 5. Verifique os logs

```sh
make logs
```
# 6. Se necessário, execute inicialização completa

```sh
make init
```

## 📋 O que o ambiente faz automaticamente:

* Instala PHP 7.2.5 + extensões necessárias

* Instala Composer e dependências do projeto

* Configura arquivo .env se não existir

* Gera APP_KEY se necessário

* Configura permissões de storage

* Inicia php artisan serve na porta 8000

# 🔧 Se encontrar problemas:

## Recriar tudo do zero

```sh
make down
make build
make up
```

# Ou forçar reinstalação das dependências

```sh
make shell
rm -rf vendor/
composer install
```

Agora o Docker vai cuidar de toda a instalação e configuração do Laravel para você! 🎉

Este ambiente vai automaticamente instalar todas as dependências e configurar seu projeto Laravel quando você executar `make up`! 🚀
