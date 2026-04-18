const BEL = "\u0007";

function ringTerminal() {
  try {
    process.stderr.write(BEL);
    return;
  } catch {}

  try {
    process.stdout.write(BEL);
  } catch {}
}

export const TmuxBellPlugin = async ({ client }) => {
  const seenPermissionRequests = new Set();
  const idleSessions = new Set();

  await client.app.log({
    body: {
      service: "tmux-bell",
      level: "info",
      message: "tmux bell plugin initialized",
    },
  });

  return {
    event: async ({ event }) => {
      if (event.type === "permission.asked") {
        if (seenPermissionRequests.has(event.properties.id)) {
          return;
        }
        seenPermissionRequests.add(event.properties.id);
        ringTerminal();
        return;
      }

      if (event.type === "permission.replied") {
        seenPermissionRequests.delete(event.properties.requestID);
        return;
      }

      if (event.type === "session.idle") {
        if (idleSessions.has(event.properties.sessionID)) {
          return;
        }
        idleSessions.add(event.properties.sessionID);
        ringTerminal();
        return;
      }

      if (event.type === "session.error") {
        ringTerminal();
      }
    },
  };
};
