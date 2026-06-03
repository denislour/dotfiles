---
name: pi-extensions
description: >
  Guide for writing Pi coding agent extensions in TypeScript.
  Covers extension structure, events, commands, tools, and deployment via Nix.
  Reference when user asks to create, modify, or debug a pi extension.
---

# Pi Extensions

> Full API reference: `~/.pi/agent/git/.../pi-monorepo/docs/extensions.md`
> Examples: `~/.pi/agent/git/.../pi-monorepo/examples/extensions/`

Extensions are TypeScript modules that extend pi's behavior. They can subscribe to lifecycle events, register custom tools callable by the LLM, add commands, and more.

## Quick Reference

```typescript
import type { ExtensionAPI } from "@mariozechner/pi-coding-agent";
import { Type } from "typebox";

export default function (pi: ExtensionAPI) {
  // Events
  pi.on("session_start", async (_event, ctx) => {});
  pi.on("session_shutdown", async (_event, ctx) => {});
  pi.on("input", async (event, ctx) => {});
  pi.on("before_agent_start", async (event, ctx) => {});
  pi.on("tool_call", async (event, ctx) => {});
  pi.on("turn_start", async (_event, ctx) => {});

  // Commands (like /mycommand)
  pi.registerCommand("name", {
    description: "...",
    getArgumentCompletions: (prefix) => [...],
    handler: async (args, ctx) => {},
  });

  // Custom tools (callable by LLM)
  pi.registerTool({
    name: "my-tool",
    label: "My Tool",
    description: "...",
    parameters: Type.Object({ ... }),
    async execute(toolCallId, params, signal, onUpdate, ctx) {
      return { content: [{ type: "text", text: "..." }], details: {} };
    },
  });

  // Send messages into conversation
  pi.sendMessage({
    customType: "my-ext",
    content: "message text",
    display: true,
  }, { triggerTurn: false });

  // User interaction
  ctx.ui.notify("text", "info" | "error" | "warning" | "success");
  ctx.ui.confirm("Title", "Question?");
  ctx.ui.input("Title", "Prompt");
  ctx.ui.select("Title", [{ value: "a", label: "A" }]);
  ctx.ui.setStatus("key", "status text");
  ctx.ui.setWidget("key", ["line1", "line2"]);
}
```

## Location & Files

| Location | Scope |
|----------|-------|
| `~/.pi/agent/extensions/*/index.ts` | Global (Nix-managed) |
| `.pi/extensions/*/index.ts` | Project-local |

In this Nix project, extensions live under `home/programs/pi/agent/extensions/<name>/index.ts`.
Add to `home/programs/pi/default.nix`:

```nix
home.file."${config.xdg.dataHome}/pi/agent/extensions/<name>/index.ts".source = ./agent/extensions/<name>/index.ts;
```

Then `cd ~/nixos && git add ... && just rebuild`.

## Key Events

### session_start
Fired on startup, new session, resume. Reset state here.

```typescript
pi.on("session_start", async (event, ctx) => {
  // event.reason - "startup" | "reload" | "new" | "resume" | "fork"
});
```

### before_agent_start
Fired before LLM call. Can inject message or modify system prompt.

```typescript
pi.on("before_agent_start", async (event, ctx) => {
  return {
    message: {
      customType: "my-ext",
      content: "Context for LLM",
      display: false,     // hide from TUI but send to LLM
    },
    systemPrompt: event.systemPrompt + "\nExtra instructions",
  };
});
```

### input
Fired on user input. Can intercept or auto-detect triggers.

```typescript
pi.on("input", async (event, ctx) => {
  const text = event.text.toLowerCase();
  if (text.includes("trigger")) {
    // handle
  }
});
```

### tool_call
Fired before tool execution. Can block or modify args.

```typescript
pi.on("tool_call", async (event, ctx) => {
  if (event.toolName === "bash" && event.input.command?.includes("rm -rf")) {
    const ok = await ctx.ui.confirm("Dangerous!", "Allow rm -rf?");
    if (!ok) return { block: true, reason: "Blocked by user" };
  }
});
```

### session_shutdown
Cleanup before runtime teardown.

```typescript
pi.on("session_shutdown", async (event, ctx) => {
  // event.reason - "quit" | "reload" | "new" | "resume" | "fork"
});
```

## Commands

```typescript
pi.registerCommand("mycmd", {
  description: "What this command does",
  getArgumentCompletions: (prefix) => {
    return ["opt1", "opt2"]
      .filter((v) => v.startsWith(prefix))
      .map((v) => ({ value: v, label: v }));
  },
  handler: async (args, ctx) => {
    const trimmed = args?.trim() || "";
    // ctx.ui for interaction
    // pi.sendMessage to inject into conversation
  },
});
```

Register commands follow convention: `/kebab-case-name`.

## Custom Tools (LLM-callable)

```typescript
pi.registerTool({
  name: "my_tool",           // snake_case for LLM
  label: "My Tool",          // Display name
  description: "Describe what this tool does for the LLM",
  parameters: Type.Object({
    query: Type.String({ description: "Search query" }),
    count: Type.Optional(Type.Number({ description: "Max results" })),
  }),
  async execute(toolCallId, params, signal, onUpdate, ctx) {
    const result = await doSomething(params.query);
    return {
      content: [{ type: "text", text: JSON.stringify(result) }],
      details: {},
    };
  },
});
```

## ctx.ui Methods

| Method | Description |
|--------|-------------|
| `notify(msg, type)` | Info/error/warning/success toast |
| `confirm(title, body)` | Yes/no prompt |
| `input(title, prompt)` | Text input |
| `select(title, options)` | Pick from list |
| `setStatus(key, text)` | Footer status bar |
| `setWidget(key, lines)` | Widget above editor |

## pi.sendMessage

Inject a custom message into the conversation (no LLM response triggered):

```typescript
pi.sendMessage({
  customType: "my-ext",      // label in theme
  content: "Display text",
  display: true,             // show in TUI
  details: { ... },          // extra data
}, {
  triggerTurn: false,        // don't trigger LLM response
  deliverAs: "nextTurn",     // queue for next turn
});
```

## State Management

Simple module-level variables reset on session change. For persistent state:

```typescript
// Save
pi.appendEntry("my-ext-key", { data: "..." });

// Load on session_start
pi.on("session_start", async (_event, ctx) => {
  const entry = ctx.sessionManager.findEntry(
    (e) => e.customType === "my-ext-key"
  );
});
```

## Existing Extensions (Reference)

### caveman (`extensions/caveman/index.ts`)
- Registers `/caveman` command with argument completions
- Uses `before_agent_start` to inject instructions into LLM context
- Uses `input` event for auto-detection of trigger phrases
- Uses `session_start` to reset state
- Module-level variable `currentLevel` for session state

### ds-balance (`extensions/ds-balance/index.ts`)
- Registers `/ds-balance` command
- Async handler fetches from external API
- Uses `pi.sendMessage()` with `triggerTurn: false` to display result in conversation
- Uses `ctx.ui.notify` for error cases
- Reads API key from `process.env.DEEPSEEK_API_KEY`

## Patterns & Conventions

- **Export default function** receiving `pi: ExtensionAPI`
- **No comments** in extension code (self-documenting)
- **JSDoc header** at top of file describing usage
- **Register command** name in kebab-case
- **Use `pi.sendMessage`** for displaying results (uses theme colors)
- **Use `ctx.ui.notify`** only for errors/warnings/notifications
- **Collocate** extension code in `home/programs/pi/agent/extensions/<name>/index.ts`
- **Add home.file entry** in `default.nix` for each extension
- **Async handlers** for API calls, file reads, etc.
