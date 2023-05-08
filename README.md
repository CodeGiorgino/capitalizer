# Capitalizer Plugin

A simple micro-editor plugin that allows to capitalize selected text.

**Installation:** run `plugin install capitalizer` and restart Micro.

## Basics

Select the text you want to capitalize, then press `Alt-p` to transform text to uppercase, or `Alt-o` to transform text to lowercase.

### Commands and Keybindings

The keybindings below are set by the plugin.

| Command   | Keybinding(s)              | What it does                                                                                | API for `bindings.json`               |
| :-------  | :------------------------- | :------------------------------------------------------------------------------------------ | :------------------------------------ |
| `toUpper` | Alt-p                      | Transform text to uppercase                                                                 | `capitalizer.up`                      |
| `toLower` | Alt-o                      | Transform text to lowercase															                              	   | `capitalizer.low`                     |
