const corsHeaders = {
  "Access-Control-Allow-Origin": Deno.env.get("SENDGRID_ALLOWED_ORIGIN") || "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
  "Access-Control-Allow-Methods": "POST, OPTIONS",
};

type InvitePayload = {
  mode?: "invite" | "feedback";
  to?: string;
  displayName?: string;
  username?: string;
  password?: string;
  role?: string;
  loginUrl?: string;
  subject?: string;
  message?: string;
  htmlMessage?: string;
};

function jsonResponse(body: Record<string, unknown>, status = 200) {
  return new Response(JSON.stringify(body), {
    status,
    headers: {
      ...corsHeaders,
      "Content-Type": "application/json",
    },
  });
}

function escapeHtml(value: string) {
  return value
    .replaceAll("&", "&amp;")
    .replaceAll("<", "&lt;")
    .replaceAll(">", "&gt;")
    .replaceAll('"', "&quot;")
    .replaceAll("'", "&#39;");
}

function textEmail(payload: Required<InvitePayload>) {
  return [
    `Hello ${payload.displayName},`,
    "",
    "Your Omena Consulting dashboard access has been created.",
    "",
    `Login: ${payload.loginUrl}`,
    `Username/email: ${payload.username}`,
    `Access code: ${payload.password}`,
    `Role: ${payload.role}`,
    "",
    "Please sign in and keep these credentials secure.",
  ].join("\n");
}

function htmlEmail(payload: Required<InvitePayload>) {
  const displayName = escapeHtml(payload.displayName);
  const loginUrl = escapeHtml(payload.loginUrl);
  const username = escapeHtml(payload.username);
  const password = escapeHtml(payload.password);
  const role = escapeHtml(payload.role);
  return `
    <div style="font-family:Arial,sans-serif;line-height:1.5;color:#17212b">
      <h2>Omena Consulting access</h2>
      <p>Hello ${displayName},</p>
      <p>Your dashboard access has been created.</p>
      <table style="border-collapse:collapse">
        <tr><td style="padding:6px 10px;font-weight:bold">Login</td><td style="padding:6px 10px"><a href="${loginUrl}">${loginUrl}</a></td></tr>
        <tr><td style="padding:6px 10px;font-weight:bold">Username/email</td><td style="padding:6px 10px">${username}</td></tr>
        <tr><td style="padding:6px 10px;font-weight:bold">Access code</td><td style="padding:6px 10px">${password}</td></tr>
        <tr><td style="padding:6px 10px;font-weight:bold">Role</td><td style="padding:6px 10px">${role}</td></tr>
      </table>
      <p>Please sign in and keep these credentials secure.</p>
    </div>
  `;
}

function htmlFeedbackEmail(displayName: string, message: string, htmlMessage?: string) {
  if (htmlMessage) {
    return htmlMessage;
  }
  return `
    <div style="font-family:Arial,sans-serif;line-height:1.5;color:#17212b">
      <h2>Omena Consulting weekly feedback</h2>
      <p>Hello ${escapeHtml(displayName)},</p>
      <div style="white-space:pre-wrap">${escapeHtml(message)}</div>
    </div>
  `;
}

async function sendWithSendGrid(options: {
  to: string;
  displayName: string;
  subject: string;
  text: string;
  html: string;
  fromEmail: string;
  fromName: string;
  apiKey: string;
}) {
  return await fetch("https://api.sendgrid.com/v3/mail/send", {
    method: "POST",
    headers: {
      Authorization: `Bearer ${options.apiKey}`,
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      personalizations: [{ to: [{ email: options.to, name: options.displayName }], subject: options.subject }],
      from: { email: options.fromEmail, name: options.fromName },
      content: [
        { type: "text/plain", value: options.text },
        { type: "text/html", value: options.html },
      ],
    }),
  });
}

async function sendWithResend(options: {
  to: string;
  subject: string;
  text: string;
  html: string;
  fromEmail: string;
  fromName: string;
  apiKey: string;
}) {
  return await fetch("https://api.resend.com/emails", {
    method: "POST",
    headers: {
      Authorization: `Bearer ${options.apiKey}`,
      "Content-Type": "application/json",
      "User-Agent": "omena-supabase-email/1.0",
    },
    body: JSON.stringify({
      from: `${options.fromName} <${options.fromEmail}>`,
      to: [options.to],
      subject: options.subject,
      text: options.text,
      html: options.html,
    }),
  });
}

async function sendEmail(options: {
  to: string;
  displayName: string;
  subject: string;
  text: string;
  html: string;
}) {
  const sendgridApiKey = Deno.env.get("SENDGRID_API_KEY");
  const sendgridFromEmail = Deno.env.get("SENDGRID_FROM_EMAIL");
  const sendgridFromName = Deno.env.get("SENDGRID_FROM_NAME") || "Omena Consulting";
  const resendApiKey = Deno.env.get("RESEND_API_KEY");
  const resendFromName = Deno.env.get("RESEND_FROM_NAME") || sendgridFromName;
  const errors: string[] = [];

  if (sendgridApiKey && sendgridFromEmail) {
    const response = await sendWithSendGrid({
      ...options,
      fromEmail: sendgridFromEmail,
      fromName: sendgridFromName,
      apiKey: sendgridApiKey,
    });
    if (response.ok) {
      return { provider: "SendGrid", response };
    }
    errors.push(`SendGrid: ${await response.text()}`);
  }

  if (resendApiKey) {
    const resendFromCandidates = [
      Deno.env.get("RESEND_FROM_EMAIL"),
      sendgridFromEmail,
      "noreply@zenatech.com",
      ["onboarding", "resend.dev"].join("@"),
    ].filter((value, index, all): value is string => Boolean(value) && all.indexOf(value) === index);

    for (const fromEmail of resendFromCandidates) {
      const response = await sendWithResend({
        to: options.to,
        subject: options.subject,
        text: options.text,
        html: options.html,
        fromEmail,
        fromName: resendFromName,
        apiKey: resendApiKey,
      });
      if (response.ok) {
        return { provider: "Resend", response };
      }
      errors.push(`Resend ${fromEmail.includes("@") ? fromEmail.split("@")[1] : "sender"}: ${await response.text()}`);
    }

    return {
      provider: "Resend",
      response: new Response(JSON.stringify({ error: errors.join(" | ") }), { status: 403 }),
    };
  }

  if (errors.length) {
    return {
      provider: "SendGrid",
      response: new Response(JSON.stringify({ error: errors.join(" | ") }), { status: 401 }),
    };
  }

  throw new Error("Missing SENDGRID_API_KEY/SENDGRID_FROM_EMAIL or RESEND_API_KEY/RESEND_FROM_EMAIL");
}

Deno.serve(async (request) => {
  if (request.method === "OPTIONS") {
    return new Response("ok", { headers: corsHeaders });
  }

  if (request.method !== "POST") {
    return jsonResponse({ error: "Method not allowed" }, 405);
  }

  try {
    const payload = await request.json() as InvitePayload;

    if (payload.mode === "feedback") {
      const to = payload.to || payload.username || "";
      const displayName = payload.displayName || payload.username || "User";
      const subject = payload.subject || "Omena Consulting weekly status feedback";
      const message = payload.message || "";
      const htmlMessage = payload.htmlMessage || "";

      if (!to || !message) {
        return jsonResponse({ error: "Missing required feedback fields" }, 400);
      }

      const { provider, response } = await sendEmail({
        to,
        displayName,
        subject,
        text: message,
        html: htmlFeedbackEmail(displayName, message, htmlMessage),
      });

      if (!response.ok) {
        const detail = await response.text();
        return jsonResponse({ error: `${provider} rejected the email request`, detail }, response.status);
      }

      return jsonResponse({
        ok: true,
        to,
        status: response.status,
        sent_at: new Date().toISOString(),
      });
    }

    const requiredPayload: Required<InvitePayload> = {
      mode: payload.mode || "invite",
      to: payload.to || payload.username || "",
      displayName: payload.displayName || payload.username || "User",
      username: payload.username || payload.to || "",
      password: payload.password || "",
      role: payload.role || "Admin",
      loginUrl: payload.loginUrl || "",
      subject: payload.subject || "",
      message: payload.message || "",
      htmlMessage: payload.htmlMessage || "",
    };

    if (!requiredPayload.to || !requiredPayload.username || !requiredPayload.password || !requiredPayload.loginUrl) {
      return jsonResponse({ error: "Missing required invite fields" }, 400);
    }

    const { provider, response } = await sendEmail({
      to: requiredPayload.to,
      displayName: requiredPayload.displayName,
      subject: "Omena Consulting access",
      text: textEmail(requiredPayload),
      html: htmlEmail(requiredPayload),
    });

    if (!response.ok) {
      const detail = await response.text();
      return jsonResponse({ error: `${provider} rejected the email request`, detail }, response.status);
    }

    return jsonResponse({
      ok: true,
      to: requiredPayload.to,
      status: response.status,
      sent_at: new Date().toISOString(),
    });
  } catch (error) {
    return jsonResponse({ error: error instanceof Error ? error.message : "Unknown error" }, 500);
  }
});

