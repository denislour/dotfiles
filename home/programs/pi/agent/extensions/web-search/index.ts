/**
 * Web Search Extension for Pi Coding Agent
 *
 * Registers a `web_search` tool callable by the LLM.
 * Uses Brave Search API for web, news, discussions, and video results.
 * Reads API key from BRAVE_SEARCH_API_KEY environment variable.
 *
 * Usage:
 *   LLM calls web_search with query, count, freshness, etc.
 */

import type { ExtensionAPI } from "@mariozechner/pi-coding-agent";
import { Type } from "typebox";

interface SearchResult {
  title: string;
  url: string;
  description?: string;
  age?: string;
  extra_snippets?: string[];
}

function formatResults(results: SearchResult[]): string {
  return results
    .map(
      (r, i) =>
        `${i + 1}. ${r.title}\n   ${r.url}\n   ${r.description ?? ""}${r.age ? ` (${r.age})` : ""}`
    )
    .join("\n\n");
}

let lastCallTime = 0;

function delay(ms: number): Promise<void> {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

async function rateLimitBrave(): Promise<void> {
  const now = Date.now();
  const elapsed = now - lastCallTime;
  if (elapsed < 1000) {
    await delay(1000 - elapsed);
  }
  lastCallTime = Date.now();
}

export default function (pi: ExtensionAPI) {
  pi.registerTool({
    name: "web_search",
    label: "Web Search",
    description:
      "Search the web for current information. Returns ranked results with title, URL, description, and age. Supports freshness filters. Use this for real-time data, news, docs, and community opinions.",
    promptSnippet: "Search the web for real-time information",
    promptGuidelines: [
      "Use web_search when you need current data, news, documentation, or community discussions.",
      "Set freshness to 'pd' or 'pw' for recent events, omit for general knowledge.",
      "Set count between 5-10 for focused results, max 20 for broad coverage.",
    ],
    parameters: Type.Object({
      query: Type.String({
        description: "Search query (1-400 chars, max 50 words)",
      }),
      count: Type.Optional(
        Type.Number({
          description: "Max results per page (1-20, default 10)",
        })
      ),
      freshness: Type.Optional(
        Type.String({
          description:
            "Time filter: 'pd' (24h), 'pw' (week), 'pm' (month), 'py' (year), or omit for all time",
        })
      ),
      searchLang: Type.Optional(
        Type.String({
          description: "Language preference (e.g., 'en', 'vi'), default 'en'",
        })
      ),
    }),
    async execute(toolCallId, params, _signal, _onUpdate, _ctx) {
      await rateLimitBrave();
      const apiKey = process.env.BRAVE_SEARCH_API_KEY;
      if (!apiKey) {
        return {
          content: [
            {
              type: "text",
              text: "Error: BRAVE_SEARCH_API_KEY environment variable not set",
            },
          ],
          details: {},
        };
      }

      const count = params.count ?? 10;
      const searchLang = params.searchLang ?? "en";
      const url = new URL("https://api.search.brave.com/res/v1/web/search");
      url.searchParams.set("q", params.query.slice(0, 400));
      url.searchParams.set("count", String(Math.min(Math.max(count, 1), 20)));
      url.searchParams.set("search_lang", searchLang);
      url.searchParams.set("safesearch", "moderate");
      if (params.freshness) {
        url.searchParams.set("freshness", params.freshness);
      }

      try {
        const res = await fetch(url.toString(), {
          headers: {
            Accept: "application/json",
            "X-Subscription-Token": apiKey,
          },
        });

        if (!res.ok) {
          return {
            content: [
              {
                type: "text",
                text: `Search API error: ${res.status} ${res.statusText}`,
              },
            ],
            details: {},
          };
        }

        const data = (await res.json()) as {
          web?: { results?: SearchResult[] };
          news?: { results?: SearchResult[] };
          discussions?: { results?: { data?: { forum_name?: string; question?: string } }[] };
        };

        const webResults = data.web?.results ?? [];
        const newsResults = data.news?.results ?? [];
        const discussionResults = data.discussions?.results ?? [];

        let output = "";

        if (webResults.length > 0) {
          output += "=== WEB RESULTS ===\n";
          output += formatResults(webResults) + "\n\n";
        }

        if (newsResults.length > 0) {
          output += "=== NEWS ===\n";
          output += formatResults(newsResults) + "\n\n";
        }

        if (discussionResults.length > 0) {
          output += "=== DISCUSSIONS ===\n";
          for (const d of discussionResults) {
            const q = d.data?.question ?? "";
            const f = d.data?.forum_name ?? "";
            if (q) output += `[${f}] ${q}\n`;
          }
        }

        if (!output) {
          output = "No results found.";
        }

        return {
          content: [{ type: "text", text: output }],
          details: { resultCount: webResults.length },
        };
      } catch (e) {
        return {
          content: [
            {
              type: "text",
              text: `Search request failed: ${e instanceof Error ? e.message : String(e)}`,
            },
          ],
          details: {},
        };
      }
    },
  });
}
