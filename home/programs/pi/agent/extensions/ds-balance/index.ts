/**
 * DeepSeek Balance Extension for Pi Coding Agent
 *
 * Check DeepSeek account balance with `/ds-balance` command.
 * Reads API key from DEEPSEEK_API_KEY environment variable.
 *
 * Usage:
 * - `/ds-balance` - Show current DeepSeek balance
 */

import type { ExtensionAPI } from "@mariozechner/pi-coding-agent";

interface BalanceInfo {
  currency: string;
  total_balance: string;
  granted_balance: string;
  topped_up_balance: string;
}

interface BalanceResponse {
  is_available: boolean;
  balance_infos: BalanceInfo[];
}

async function fetchBalance(): Promise<BalanceResponse | string> {
  const apiKey = process.env.DEEPSEEK_API_KEY;
  if (!apiKey) {
    return "DEEPSEEK_API_KEY not set";
  }

  try {
    const res = await fetch("https://api.deepseek.com/user/balance", {
      headers: {
        Authorization: `Bearer ${apiKey}`,
        Accept: "application/json",
      },
    });

    if (!res.ok) {
      return `API error: ${res.status} ${res.statusText}`;
    }

    return (await res.json()) as BalanceResponse;
  } catch (e) {
    return `Request failed: ${e instanceof Error ? e.message : String(e)}`;
  }
}

function formatBalance(data: BalanceResponse): string {
  const lines = data.balance_infos.map((b) => {
    const parts = [`${b.currency} ${b.total_balance}`];
    if (b.granted_balance !== "0.00") parts.push(`granted ${b.granted_balance}`);
    if (b.topped_up_balance !== "0.00") parts.push(`topped up ${b.topped_up_balance}`);
    return parts.join(" | ");
  });
  return `DeepSeek Balance: ${lines.join(", ")}`;
}

export default function (pi: ExtensionAPI) {
  pi.registerCommand("ds-balance", {
    description: "Check DeepSeek account balance",
    handler: async (_args, ctx) => {
      const result = await fetchBalance();

      if (typeof result === "string") {
        ctx.ui.notify(`Balance check failed: ${result}`, "error");
        return;
      }

      ctx.ui.notify(formatBalance(result), "info");
    },
  });
}
