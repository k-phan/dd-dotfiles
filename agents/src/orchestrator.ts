import { query } from "@anthropic-ai/claude-agent-sdk";
import { ticketWorker } from "./agents/ticket-worker.js";

async function main() {
  const ticketInput = process.argv[2];
  if (!ticketInput) {
    console.error("Usage: npm run orchestrator -- <ticket-url-or-id>");
    process.exit(1);
  }

  // TODO: Fetch ticket details from Jira API using ticketInput
  // For now, pass the raw input to the orchestrator prompt

  for await (const message of query({
    prompt: `You are a ticket orchestrator. Process the following ticket:

${ticketInput}

Steps:
1. Create a new branch from main with a descriptive name based on the ticket (e.g. khai/TICKET-123-short-description).
2. Delegate the implementation to the ticket-worker agent, passing it the full ticket details.
3. Report back with the draft PR URL when complete.`,

    options: {
      allowedTools: ["Bash", "Task"],
      agents: {
        "ticket-worker": ticketWorker,
      },
      permissionMode: "acceptEdits",
    },
  })) {
    if ("result" in message) {
      console.log(message.result);
    }
  }
}

main().catch(console.error);
