# Neovim Config (Custom Kickstart)

Una configuración de Neovim moderna, modular y ultrarrápida, basada en la nueva API de Neovim 0.11+.

## 🚀 Instalación

Para instalar esta configuración, clona este repositorio en tu carpeta de configuración de Neovim:

```bash
git clone https://github.com/tu-usuario/tu-repo.git ~/.config/nvim
```

Luego, simplemente abre Neovim:

```bash
nvim
```

La configuración detectará automáticamente los plugins y herramientas faltantes a través de Mason y los instalará en el primer arranque.

## 📋 Requisitos

### Obligatorios (Core)

*   **Neovim >= 0.11.0**: Esta configuración utiliza las nuevas APIs nativas de LSP que solo están disponibles en las versiones más recientes.
*   **Compilador de C**: Necesario para que `nvim-treesitter` pueda compilar los parsers de los lenguajes (ej: `gcc`, `clang` o `zig`).
*   **Herramientas base**: `git`, `curl`, `unzip`, `tar`, `gzip` (Mason las necesita para descargar e instalar servidores).

### Opcionales (Recomendados para la mejor experiencia)

*   **Nerd Font**: Imprescindible para ver los iconos en el dashboard, statusline y buscadores. (Ej: JetBrainsMono Nerd Font).
*   **ripgrep (rg)**: Para búsquedas de texto rápidas con el buscador de Snacks.
*   **fd**: Para una búsqueda de archivos más rápida.
*   **Node.js & npm/pnpm/yarn**: Necesario para los servidores de lenguaje de Web (TypeScript, Vue, Prettier).
*   **Go**: Necesario para el desarrollo en Go y el servidor `gopls`.
*   **shell-color-scripts**: Para que el terminal del Dashboard muestre los colores correctamente (comando `colorscript`).
*   **lazygit**: Para usar la interfaz de Git integrada (`<leader>lg`).
*   **OpenCode CLI**: Necesario si deseas utilizar la integración de IA (`opencode.nvim`).

## 📁 Estructura del Proyecto

*   `init.lua`: Punto de entrada principal.
*   `lua/config/`: Configuraciones básicas (opciones, keymaps, autocmnd).
*   `lua/plugins/`:
    *   `lsp/`: Configuración modular de servidores de lenguaje (un archivo por servidor).
    *   `snacks.lua`: Dashboard, buscador, explorador y utilidades.
    *   `ui.lua`: Apariencia, statusline y tema (Catppuccin).
    *   `extras/`: Funcionalidades opcionales (OpenCode, Autopairs, etc.).

## ⌨️ Atajos Principales

*   `<leader>sf`: Buscar archivos.
*   `<leader>sg`: Buscar por texto (Grep).
*   `<leader>lg`: Abrir Lazygit.
*   `<C-n>`: Alternar explorador de archivos.
*   `<C-a>`: Preguntar a OpenCode AI.
*   `grr`: Ver referencias (LSP).
*   `grn`: Renombrar símbolo (LSP).

---
*Nota: Después de instalar, puedes ejecutar `:checkhealth` dentro de Neovim para verificar si falta alguna dependencia opcional.*
