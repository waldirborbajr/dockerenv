#!/bin/bash

cd /app

# Verificar se o projeto Vue já existe
if [ ! -f "package.json" ]; then
    echo "🚀 Criando novo projeto Vue.js..."
    
    # Primeiro, criar um package.json básico
    cat > package.json << 'EOL'
{
  "name": "vue-app",
  "version": "0.0.0",
  "scripts": {
    "dev": "vite",
    "build": "vite build",
    "preview": "vite preview"
  },
  "dependencies": {
    "vue": "^3.3.0"
  },
  "devDependencies": {
    "@vitejs/plugin-vue": "^4.2.0",
    "vite": "^4.3.0"
  }
}
EOL

    # Instalar Vite e Vue primeiro
    echo "📦 Instalando Vite e Vue..."
    yarn add vue @vitejs/plugin-vue vite
    
    # Criar estrutura básica do projeto
    mkdir -p src/components src/assets
    
    # Criar vite.config.js
    cat > vite.config.js << 'EOL'
import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'

export default defineConfig({
  plugins: [vue()],
  server: {
    host: '0.0.0.0',
    port: 8080
  }
})
EOL

    # Criar index.html
    cat > index.html << 'EOL'
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <link rel="icon" type="image/svg+xml" href="/vite.svg">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vue App</title>
  </head>
  <body>
    <div id="app"></div>
    <script type="module" src="/src/main.js"></script>
  </body>
</html>
EOL

    # Criar main.js
    cat > src/main.js << 'EOL'
import { createApp } from 'vue'
import App from './App.vue'
import './assets/main.css'

createApp(App).mount('#app')
EOL

    # Criar App.vue
    cat > src/App.vue << 'EOL'
<template>
  <div>
    <h1>Vue.js App</h1>
    <p>Projeto criado com sucesso!</p>
  </div>
</template>

<script>
export default {
  name: 'App'
}
</script>
EOL

    # Criar CSS básico
    mkdir -p src/assets
    cat > src/assets/main.css << 'EOL'
body {
  font-family: Arial, sans-serif;
  margin: 0;
  padding: 20px;
}
EOL

    # Instalar bibliotecas adicionais
    echo "📚 Instalando Axios, Bootstrap e Tailwind..."
    yarn add axios bootstrap @popperjs/core
    yarn add -D tailwindcss postcss autoprefixer
    
    # Inicializar Tailwind
    echo "🎨 Configurando Tailwind CSS..."
    npx tailwindcss init -p
    
    # Configurar Tailwind
    cat > tailwind.config.js << 'EOL'
/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./index.html",
    "./src/**/*.{vue,js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}
EOL

    # Atualizar CSS com Bootstrap e Tailwind
    cat > src/assets/main.css << 'EOL'
/* Bootstrap */
@import 'bootstrap/dist/css/bootstrap.css';

/* Tailwind CSS */
@tailwind base;
@tailwind components;
@tailwind utilities;

body {
  font-family: Arial, sans-serif;
  margin: 0;
  padding: 20px;
}
EOL

    echo "✨ Configuração concluída! Todas as bibliotecas instaladas."
else
    echo "📁 Projeto já existe. Instalando dependências..."
    yarn install
fi

echo "🚀 Iniciando servidor de desenvolvimento..."
exec yarn dev