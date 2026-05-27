# Agent Instructions

You must use Zed's built-in tools for all file operations. Do not use external shell commands like python3, sed, awk, or similar to read, write, edit, create, or delete files.

Available built-in tools:
- read — read file contents
- edit — make precise edits to files
- write_file — create or overwrite files
- create_directory — create directories
- delete_path — delete files or directories
- copy_path — copy files or directories
- move_path — move or rename files or directories
- search_web — search the web (via Brave Search MCP)
- terminal — run terminal commands (only for non-file operations)

When working on a project, always check if a `.pi/skills/` directory exists in the project root. If it exists, read all files inside it to understand the skills and conventions defined for working with that project's codebase.
