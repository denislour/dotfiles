/**
 * Focus Mode Extension for Pi Coding Agent
 *
 * 1. Collapses thinking blocks by default, shows "💭 Thinking..." label
 * 2. Ctrl+Shift+O opens overlay with full thinking content
 * 3. Injects concise/caveman instructions to save tokens
 * 4. Shows 1-line summary in footer after thinking completes
 *
 * Commands:
 *   /focus          Toggle focus mode on/off
 *
 * Keybindings:
 *   Ctrl+Shift+O    Open thinking content overlay
 */

import type { ExtensionAPI } from "@mariozechner/pi-coding-agent";
import { Text } from "@earendil-works/pi-tui";

let active = true;
let thinkingAccumulated = "";

export default function (pi: ExtensionAPI) {
  pi.on("session_start", async (_event, ctx) => {
    active = true;
    thinkingAccumulated = "";
    ctx.ui.setHiddenThinkingLabel("💭 Thinking...");
  });

  pi.on("turn_start", async () => {
    thinkingAccumulated = "";
  });

  pi.on("message_update", async (event) => {
    if (!active) return;
    if (event.message.role !== "assistant") return;

    for (const block of event.message.content) {
      if (block.type === "thinking" && "thinking" in block) {
        thinkingAccumulated = block.thinking as string;
      }
    }
  });

  pi.on("message_end", async (event, ctx) => {
    if (!active) return;
    if (event.message.role !== "assistant") return;

    const hasThinking = event.message.content.some(
      (c) => c.type === "thinking"
    );
    if (!hasThinking) return;

    const summary = thinkingAccumulated
      ? thinkingAccumulated.split("\n")[0].trim().slice(0, 120)
      : "Thought through the problem";

    ctx.ui.setStatus("focus-summary", `Thought: ${summary}`);
  });

  pi.on("before_agent_start", async (event, ctx) => {
    if (!active) return;

    return {
      message: {
        role: "user",
        content: [
          {
            type: "text",
            text: `[FOCUS MODE] Respond concisely. Drop filler words, pleasantries, hedging. Short sentences, keep technical terms exact. After thinking, give a brief 1-line summary of your reasoning.`,
          },
        ],
        display: false,
      },
    };
  });

  pi.registerCommand("focus", {
    description: "Toggle focus mode on/off",
    handler: async (_args, ctx) => {
      active = !active;
      ctx.ui.notify(active ? "Focus mode ON" : "Focus mode OFF", "info");
      if (active) {
        ctx.ui.setHiddenThinkingLabel("💭 Thinking...");
      } else {
        ctx.ui.setHiddenThinkingLabel();
      }
    },
  });

  pi.registerShortcut("ctrl+shift+o", {
    description: "Open thinking content overlay",
    handler: async (ctx) => {
      if (!thinkingAccumulated) {
        ctx.ui.notify("No thinking content available", "info");
        return;
      }

      ctx.ui.custom<null>(
        (_tui, theme, _keybindings, done) => {
          const lines = thinkingAccumulated.split("\n");
          const displayLines = lines.slice(0, 200);
          const text =
            theme.bold(" ═══ Thinking Content ═══ ") +
            "\n" +
            displayLines.join("\n") +
            "\n" +
            theme.fg("dim", " Press Escape or Ctrl+C to close ");

          const component = new Text(text, 1, 1);
          component.onKey = (key) => {
            if (key === "escape" || key === "ctrl+c") {
              done(null);
              return true;
            }
            return false;
          };
          return component;
        },
        { overlay: true }
      );
    },
  });
}
