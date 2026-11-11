# pstack in OpenCode

pstack skills were originally designed with Cursor and Claude Code conventions. In OpenCode, follow this guide for tool and workflow mapping. `<pstack>` means `~/.config/opencode/skills/`.

## Tools

| Concept / Cursor | OpenCode | Notes |
| --- | --- | --- |
| `Task` | `subagent` | `agent: "explore"` (read-only search), `"general"` (general-purpose), `"poteto-agent"` (delegate), or `"comment-sicko"`. |
| `AskQuestion` | `question` | In OpenCode, use the `question` tool with `{ questions: [{ header, question, options }] }`. |
| Open a todolist | Conversation message checklist | Maintain a markdown checklist (`- [ ]`, `- [x]`) in your reply and update it at each phase. |
| Run another pstack skill (`/name` or "the **name** skill") | `skill` tool | Call `skill({ id: "<name>" })` or invoke `/name`. |
| `Grep`, `Glob`, `ReadFile`, `EditFile`, `CreateFile` | `grep`, `glob`, `read`, `edit`, `write` | Native OpenCode tools. For shell searches, use `rg` and `fd`. |
| `Bash` | `shell` | Run shell commands using the `shell` tool. Prefer dedicated tools when available. |

## Subagent fields

| Cursor / Spec | OpenCode |
| --- | --- |
| `subagent_type: generalPurpose` | `agent: "general"` |
| `subagent_type: "poteto-agent"` | `agent: "poteto-agent"` |
| `subagent_type: "comment-sicko"` | `agent: "comment-sicko"` |
| `readonly: true` | `agent: "explore"` (or `agent: "general"` with explicit read-only instructions in prompt) |
| `readonly: false` | `agent: "general"` or `agent: "poteto-agent"` |
| `environment: "cloud"` | Git worktree via `tools.opencode.worktree_create` or `git worktree add` |
| `environment: "local"` | Run directly in working directory |
| `cloud_base_branch: <b>` | Check out branch `<b>` in the worktree |
| `run_in_background: true` | `background: true` in `subagent` call |
| `resume` | Pass `sessionID` to `subagent` call |
| `file_attachments` | Include relative or absolute paths in the prompt |

## Models

| Role / Slug | OpenCode Format |
| --- | --- |
| Model IDs | `providerID/modelID` (e.g. `google/gemini-3.8-flash`, `google-vertex/claude-opus-5-5@default`) |
| `inherit-parent` or `auto` | Omit `model` parameter to use the session model |
| Model configuration rule | `~/.config/opencode/pstack-models.md` loaded via `"instructions"` in `~/.config/opencode/opencode.json` |

## Paths

| Cursor Path | OpenCode Path |
| --- | --- |
| `.cursor/skills/`, `~/.cursor/skills/` | `~/.config/opencode/skills/` |
| `~/.cursor/rules/pstack-models.mdc` | `~/.config/opencode/pstack-models.md` |
| `~/.cursor/plugins/` | `~/.config/opencode/` |
| `~/.cursor/projects/<slug>/agent-transcripts/` | OpenCode API `/api/session` or `~/.local/share/opencode/` |

## Cursor-only features

OpenCode has no proprietary Cursor Automations, Bugbot, or cloud agents.

- **Bugbot / Review bots:** PR/MR review comments are fetched and handled via GitHub CLI (`gh`) or GitLab CLI (`glab`).
- **Cloud agents:** Replaced with local Git worktrees.
- **PRs / MRs:** Use `glab mr create` (for GitLab repositories) or `gh pr create` (for GitHub repositories).
