#!/bin/bash

# Caminho do diretório de configurações do VS Code
CONFIG_DIR="$HOME/.config/Code/User"
SETTINGS_FILE="$CONFIG_DIR/settings.json"

# Lista de extensões para instalar
EXTENSIONS=(
    charliermarsh.ruff
    eamodio.gitlens
    markosth09.color-picker
    mechatroner.rainbow-csv
    ms-python.debugpy
    ms-python.python
    ms-python.vscode-pylance
    oderwat.indent-rainbow
    qcz.text-power-tools
    roscop.activefileinstatusbar
    shardulm94.trailing-spaces
    tyriar.luna-paint
    visualstudioexptteam.intellicode-api-usage-examples
    visualstudioexptteam.vscodeintellicode
    tomoki1207.pdf
    usernamehw.indent-one-space
    kevinrose.vsc-python-indent

)

echo "🔧 Instalando extensões do VS Code..."
for EXT in "${EXTENSIONS[@]}"; do
    code --install-extension "$EXT" --force
done

echo "📂 Criando diretório de configurações se não existir: $CONFIG_DIR"
mkdir -p "$CONFIG_DIR"

echo "📄 Escrevendo arquivo settings.json..."
cat > "$SETTINGS_FILE" << 'EOF'
{
    // ----EDITOR----
    "editor.autoClosingBrackets": "always",
    "editor.bracketPairColorization.independentColorPoolPerBracketType": true,
    "editor.definitionLinkOpensInPeek": true,
    "editor.emptySelectionClipboard": false,
    "editor.experimentalWhitespaceRendering": "off",
    "editor.fastScrollSensitivity": 4,
    "editor.foldingMaximumRegions": 500,
    "editor.gotoLocation.alternativeTypeDefinitionCommand": "editor.action.goToImplementation",
    "editor.gotoLocation.multipleDeclarations": "gotoAndPeek",
    "editor.guides.bracketPairs": true,
    "editor.inlayHints.padding": true,
    "editor.mouseWheelScrollSensitivity": 1.1,
    "editor.multiCursorLimit": 50000,
    "editor.padding.bottom": 1,
    "editor.padding.top": 1,
    "editor.tabCompletion": "on",
    "editor.stickyTabStops": true,
    "editor.unfoldOnClickAfterEndOfLine": true,
    "editor.unicodeHighlight.nonBasicASCII": false,
    "editor.wrappingIndent": "indent",
    "editor.fontWeight": "normal",
    "editor.fontFamily": "JetBrains Mono",
    "editor.fontLigatures": true,
    "editor.formatOnPaste": true,
    "editor.inlineSuggest.showToolbar": "always",
    "editor.quickSuggestions": {
        "other": "on",
        "comments": "on",
        "strings": "on"
    },
    "editor.quickSuggestionsDelay": 3,
    "editor.screenReaderAnnounceInlineSuggestion": false,
    "editor.suggest.filterGraceful": false,
    "editor.suggest.matchOnWordStartOnly": false,
    "editor.suggest.preview": true,
    "editor.suggest.shareSuggestSelections": true,
    "editor.suggestSelection": "first",
    "editor.mouseWheelZoom": false,
    "editor.defaultFormatter": null,
    "editor.minimap.scale": 1,
    "editor.accessibilityPageSize": 1,
    "editor.accessibilitySupport": "off",
    // ----WORKBENCH----
    "workbench.startupEditor": "none",
    "workbench.commandPalette.experimental.suggestCommands": true,
    "workbench.commandPalette.history": 50000,
    "workbench.commandPalette.preserveInput": true,
    "workbench.enableExperiments": false,
    "workbench.experimental.share.enabled": true,
    "workbench.list.fastScrollSensitivity": 6,
    "workbench.list.scrollByPage": true,
    "workbench.list.smoothScrolling": true,
    "workbench.localHistory.maxFileEntries": 5000,
    "workbench.localHistory.maxFileSize": 8192,
    "workbench.reduceMotion": "on",
    "workbench.tips.enabled": false,
    "workbench.tree.enableStickyScroll": true,
    "workbench.editor.autoLockGroups": {
        "terminalEditor": false
    },
    "workbench.editor.limit.enabled": false,
    "workbench.settings.enableNaturalLanguageSearch": false,
    "workbench.editor.wrapTabs": true,
    "workbench.editor.limit.value": 10000,
    "workbench.editor.pinnedTabsOnSeparateRow": true,
    "workbench.editor.sharedViewState": true,
    "workbench.iconTheme": "bearded-icons",
    "workbench.colorTheme": "Eva Dark",
    "workbench.activityBar.location": "top",
    "workbench.editor.highlightModifiedTabs": true,
    // ----MISC----
    "window.menuBarVisibility": "compact",
    "prettier.resolveGlobalModules": true,
    "clipboard-manager.snippet.enabled": false,
    "luna.retainContextWhenHidden": false,
    "diffEditor.experimental.showMoves": true,
    "diffEditor.hideUnchangedRegions.enabled": true,
    "diffEditor.hideUnchangedRegions.minimumLineCount": 1,
    "diffEditor.maxComputationTime": 0,
    "diffEditor.maxFileSize": 0,
    "multiDiffEditor.experimental.enabled": true,
    "material-icon-theme.files.color": "#26a69a",
    "cmake.showOptionsMovedNotification": false,
    "window.zoomLevel": 0.4,
    "editor.wordWrap": "wordWrapColumn",
    "editor.wordWrapColumn": 90,
    // ----EXTENSIONS----
    "extensions.autoUpdate": false
}
EOF

echo "✅ Configuração do VS Code concluída com sucesso!"
