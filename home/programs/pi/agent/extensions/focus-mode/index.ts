/**
 * Focus Mode Extension for Pi Coding Agent
 *
 * 1. Collapses thinking blocks by default, shows "⚡ Thinking..." label
 * 2. Ctrl+Shift+O opens overlay with full thinking content
 * 3. Injects concise/Vietnamese instructions to save tokens
 * 4. Shows 1-line Vietnamese summary in footer after thinking completes
 * 5. Forces thinking/reasoning in Vietnamese
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
let lastLabelLine = "";

export default function (pi: ExtensionAPI) {
  pi.on("session_start", async (_event, ctx) => {
    active = true;
    thinkingAccumulated = "";
    lastLabelLine = "";
    ctx.ui.setHiddenThinkingLabel("⚡ Đang thinking...");
  });

  pi.on("turn_start", async () => {
    thinkingAccumulated = "";
    lastLabelLine = "";
  });

  pi.on("message_update", async (event, ctx) => {
    if (!active) return;
    if (event.message.role !== "assistant") return;

    for (const block of event.message.content) {
      if (block.type === "thinking" && "thinking" in block) {
        const thinking = block.thinking as string;
        thinkingAccumulated = thinking;

        const firstLine = thinking.split("\n")[0].trim().slice(0, 60);
        if (firstLine && firstLine !== lastLabelLine) {
          lastLabelLine = firstLine;
          ctx.ui.setHiddenThinkingLabel(`⚡ ${firstLine}...`);
        }
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

    ctx.ui.setHiddenThinkingLabel(`⚡ ${summary}`);
    ctx.ui.setStatus("focus-summary", `⚡ Tóm tắt: ${summary}`);

    return {
      message: {
        ...event.message,
        content: event.message.content.map((block) => {
          if (block.type === "thinking") {
            return { type: "text" as const, text: `⚡ ${summary}` };
          }
          return block;
        }),
      },
    };
  });

  pi.on("before_agent_start", async (event, ctx) => {
    if (!active) return;

    ctx.ui.setStatus("focus-mode", "⚡ Focus ON");

    return {
      systemPrompt:
        event.systemPrompt +
        `\n\n[FOCUS MODE] Trả lời bằng tiếng Việt có dấu. Ngắn gọn, đúng trọng tâm. Bỏ từ đệm, khách sáo. Giữ nguyên thuật ngữ chuyên môn.\n\nToàn bộ thinking/reasoning phải bằng tiếng Việt, không dùng tiếng Anh.\nSau thinking, tóm tắt 1 dòng lý do (tiếng Việt).`,
    };
  });

  pi.registerCommand("focus", {
    description: "Toggle focus mode on/off",
    handler: async (_args, ctx) => {
      active = !active;
      ctx.ui.notify(active ? "Focus mode BẬT" : "Focus mode TẮT", "info");
      if (active) {
        ctx.ui.setHiddenThinkingLabel("⚡ Đang thinking...");
      } else {
        ctx.ui.setHiddenThinkingLabel();
      }
    },
  });

  pi.registerShortcut("ctrl+shift+o", {
    description: "Open thinking content overlay",
    handler: async (ctx) => {
      if (!thinkingAccumulated) {
        ctx.ui.notify("Không có nội dung thinking", "info");
        return;
      }

      ctx.ui.custom<null>(
        (_tui, theme, _keybindings, done) => {
          const lines = thinkingAccumulated.split("\n");
          const displayLines = lines.slice(0, 200);
          const text =
            theme.bold(" ═══ Nội dung Thinking ═══ ") +
            "\n" +
            displayLines.join("\n") +
            "\n" +
            theme.fg("dim", " Nhấn Escape hoặc Ctrl+C để đóng ");

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
