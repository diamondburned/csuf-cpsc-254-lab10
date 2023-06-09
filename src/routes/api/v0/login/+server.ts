import * as api from "#/lib/api/index.js";
import * as db from "#/lib/db/index.js";
import type * as sveltekit from "@sveltejs/kit";

export async function POST(ev: sveltekit.ServerLoadEvent): Promise<Response> {
  try {
    const body: api.LoginRequest = await ev.request.json();

    const user = await db.client.user.findUniqueOrThrow({
      where: { username: body.username },
    });

    const correct = await db.comparePassword(user.passhash, body.password);
    if (!correct) {
      throw new Error("Invalid username or password");
    }

    let resp: api.LoginResponse;
    try {
      const session = await db.createSession(user);
      resp = {
        id: session.id.toString(),
        userID: session.userID.toString(),
        token: session.token,
        expiresAt: session.expiresAt.toISOString() as api.Timestamp,
      };
    } catch (err) {
      return api.respondError(500, err);
    }

    return api.respond(resp);
  } catch (err) {
    return api.respondError(401, err);
  }
}
