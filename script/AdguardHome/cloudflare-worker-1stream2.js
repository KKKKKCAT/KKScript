const url = "https://raw.githubusercontent.com/1-stream/1stream-public-utils/refs/heads/main/stream.text.list";

addEventListener("fetch", (event) => {
  event.respondWith(handleRequest(event.request));
});

async function handleRequest(request) {
  if (request.method === "GET") {
    // 返回基本的 HTML 前端
    return new Response(
      `
      <!DOCTYPE html>
      <html lang="en">
      <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Cloudflare Worker Text Processor</title>
      </head>
      <body>
        <h1>Enter IP and Generate Formatted Domains</h1>
        <form id="form">
          <input type="text" id="ip" name="ip" placeholder="Enter IP address" required />
          <button type="button" id="submit">Submit</button>
        </form>
        <pre id="result"></pre>
        <script>
          document.getElementById('submit').addEventListener('click', async () => {
            const ip = document.getElementById('ip').value;
      
            if (!ip) {
              alert("Please enter an IP address.");
              return;
            }
      
            const response = await fetch(location.href, {
              method: "POST",
              headers: { "Content-Type": "application/json" },
              body: JSON.stringify({ ip }),
            });
      
            if (response.ok) {
              const result = await response.text();
              document.getElementById('result').textContent = result;
            } else {
              document.getElementById('result').textContent = "Error: " + response.statusText;
            }
          });
        </script>
      </body>
      </html>
      `,
      { headers: { "Content-Type": "text/html" } }
    );
  }

  if (request.method === "POST") {
    try {
      const { ip } = await request.json();

      // 驗證 IP
      if (
        !ip ||
        !/^(25[0-5]|2[0-4][0-9]|[0-1]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[0-1]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[0-1]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[0-1]?[0-9][0-9]?)$/.test(ip)
      ) {
        return new Response("Invalid IP address", { status: 400 });
      }

      // 獲取 URL 資料
      const response = await fetch(url);
      const content = await response.text();

      // 處理內容
      const lines = content.split("\n");
      const formattedLines = [];
      let currentCategory = "";

      for (const line of lines) {
        if (line.startsWith("# ---------- >")) {
          currentCategory = line;
          formattedLines.push(line);
        } else if (line.startsWith("# >")) {
          formattedLines.push(line);
        } else if (line && !line.startsWith("#")) {
          // 保留原始規則
          formattedLines.push(`||${line.trim()}^$dnsrewrite=NOERROR;A;${ip}`);
          // 增加帶有 *. 的規則
          formattedLines.push(`||*.${line.trim()}^$dnsrewrite=NOERROR;A;${ip}`);
        }
      }

      // 返回格式化內容
      const result = formattedLines.join("\n");
      return new Response(result, { headers: { "Content-Type": "text/plain" } });
    } catch (error) {
      return new Response(`Error: ${error.message}`, { status: 500 });
    }
  }

  return new Response("Method not allowed", { status: 405 });
}
