# Configuración de Neovim (Custom Kickstart)

[Read in English 🇬🇧](README.md)

Una configuración de Neovim moderna, modular y ultrarrápida, basada en las nuevas APIs nativas de LSP de Neovim 0.11+.

## 🚀 Instalación

Para instalar esta configuración, clona este repositorio en tu carpeta de configuración de Neovim:

### Linux / macOS
```bash
git clone https://github.com/Giankrp/NeovimConfig ~/.config/nvim
```

### Windows (PowerShell - Recomendado)
```bash
git clone https://github.com/Giankrp/NeovimConfig $env:LOCALAPPDATA\nvim
```

### Windows (cmd)
```bash
git clone https://github.com/Giankrp/NeovimConfig %LOCALAPPDATA%\nvim
```

Luego, simplemente abre Neovim:
```bash
nvim
```

## ⚡ Configuración Express en Windows (Recomendado)

Si estás en Windows, la forma más limpia y rápida de instalar Neovim y todas las dependencias necesarias mencionadas abajo (compiladores, motores de búsqueda y entornos) es usando [Scoop](https://scoop.sh/).
La configuración detectará automáticamente los plugins y herramientas faltantes a través de Mason y los instalará en el primer arranque.

> [!WARNING]
> Revisa siempre el script de instalación de Scoop en la documentación oficial (el enlace está en el texto de arriba) por si el script de instalación cambia.

### Ejecutar en PowerShell
```bash
# 1. Instalar Scoop (si no lo tienes)
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression

# 2. Agregar los repositorios necesarios
scoop bucket add extras

# 3. Instalar TODO el entorno de golpe (Core + Herramientas recomendadas)
scoop install neovim git zig ripgrep fd nodejs-lts go lazygit tree-sitter
```

## 📋 Requisitos

### Obligatorios (Core)

*   **Neovim >= 0.11.0**: Esta configuración utiliza las nuevas APIs nativas de LSP que solo están disponibles en versiones recientes.
*   **Compilador de C**: Necesario para que `nvim-treesitter` pueda compilar los parsers de los lenguajes (ej. `gcc`, `clang` o `zig`).
*   **tree-sitter-cli**: Requerido por `nvim-treesitter` para la generación y compilación de parsers.
    *   *Cómo instalar*:
        *   **npm**: `npm install -g tree-sitter-cli`
        *   **Scoop (Windows)**: `scoop install tree-sitter`
        *   **Homebrew (macOS)**: `brew install tree-sitter`
        *   **Cargo**: `cargo install tree-sitter-cli`
*   **Herramientas base**: `git`, `curl`, `unzip`, `tar`, `gzip` (necesarios para que Mason descargue e instale servidores).

### Opcionales (Recomendados para la mejor experiencia)

*   **Nerd Font**: Requerido para ver iconos en el dashboard, statusline y ventanas de búsqueda (ej. JetBrainsMono Nerd Font).
*   **ripgrep (rg)**: Para búsquedas de texto ultra rápidas mediante Snacks picker.
*   **fd**: Para búsquedas de archivos más rápidas.
*   **Node.js & npm/pnpm/yarn**: Necesario para los servidores de lenguaje de desarrollo web (TypeScript, Vue, Prettier).
*   **Go**: Necesario para el desarrollo en Go y el servidor de lenguaje `gopls`.
*   **shell-color-scripts**: Para que la terminal del dashboard muestre los colores correctamente (comando `colorscript`).
*   **lazygit**: Para usar la interfaz integrada de Git (`<leader>lg`).
*   **OpenCode CLI**: Necesario si deseas usar la integración de IA (`opencode.nvim`).
    > [!WARNING]
    > **Rendimiento en Windows / PowerShell**: Levantar el servidor de OpenCode automáticamente desde Neovim en Windows puede causar latencia (lag). Se recomienda encarecidamente iniciarlo manualmente en una terminal externa ejecutando `opencode --port 3000` y descomentar la opción `server` en `lua/plugins/extras/opencode.lua` para conectarse a esa URL.

## 📁 Estructura del Proyecto

*   `init.lua`: Punto de entrada principal.
*   `lua/config/`: Ajustes del core (opciones, keymaps, autocomandos, hooks de compilación).
*   `lua/plugins/`:
    *   `lsp/`: Configuraciones modulares de servidores de lenguaje (un archivo por servidor).
    *   `snacks.lua`: Dashboard, picker, explorador, utilidades.
    *   `ui.lua`: Apariencia, statusline, tema (Catppuccin).
    *   `extras/`: Funcionalidades opcionales (OpenCode, Autopairs, DAP, etc.).

## ⌨️ Atajos de Teclado Principales

*   `<leader>sf`: Buscar archivos.
*   `<leader>sg`: Buscar texto (Grep).
*   `<leader>lg`: Abrir Lazygit.
*   `<C-n>`: Alternar explorador de archivos.
*   `<C-a>`: Preguntar a OpenCode AI.
*   `<leader>bd`: Eliminar buffer actual.
*   `<leader>gb`: Abrir archivo/líneas actuales en la web de Git (GitHub/GitLab/etc.).
*   `<leader>bs`: Alternar buffer borrador (scratchpad).
*   `grr`: Ir a referencias (LSP).
*   `grn`: Renombrar símbolo (LSP).

---
*Nota: Después de instalar, puedes ejecutar `:checkhealth` dentro de Neovim para verificar si falta alguna dependencia opcional.*
