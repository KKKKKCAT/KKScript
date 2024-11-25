addEventListener("fetch", (event) => {
  event.respondWith(handleRequest(event.request));
});

async function handleRequest(request) {
  const url = "https://raw.githubusercontent.com/KKKKKCAT/KKScript/refs/heads/main/script/AdguardHome/stream.list";

  if (request.method === "POST") {
    try {
      const { ip, category } = await request.json();

      // 檢查 IP 是否有效
      if (
        !ip ||
        !/^(25[0-5]|2[0-4][0-9]|[0-1]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[0-1]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[0-1]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[0-1]?[0-9][0-9]?)$/.test(ip)
      ) {
        return new Response("Invalid IP address", { status: 400 });
      }

      // 獲取內容
      const response = await fetch(url);
      const content = await response.text();

      // 分割內容逐行解析
      const lines = content.split("\n");
      let startCollecting = false;
      const categoryData = [];

      for (const line of lines) {
        // 開始收集數據
        if (line.trim() === `# ---------- > ${category}`) {
          startCollecting = true;
          categoryData.push(line); // 包括分類標題
          continue;
        }

        // 停止收集數據（遇到下一個分類）
        if (startCollecting && line.startsWith("# ---------- >") && line.trim() !== `# ---------- > ${category}`) {
          break;
        }

        // 收集分類內容
        if (startCollecting) {
          categoryData.push(line);
        }
      }

      // 如果未找到數據，返回錯誤
      if (!categoryData.length) {
        return new Response(`No data found for category: ${category}`, { status: 404 });
      }

      // 將數據拼接回原始格式
      let extractedData = categoryData.join("\n").trim();

      // 替換 <DNS> 為用戶提供的 IP
      extractedData = extractedData.replace(/<DNS>/g, ip);

      return new Response(extractedData, {
        headers: { "Content-Type": "text/plain" },
      });
    } catch (error) {
      return new Response("Error processing request", { status: 500 });
    }
  }

  // 渲染前端界面
  const response = await fetch(url);
  const content = await response.text();
  const categories = [...content.matchAll(/# ---------- > (.+)/g)].map((match) => match[1]);

  const dropdownOptions = categories
    .map((category) => `<option value="${category}">${category}</option>`)
    .join("");

  return new Response(
    `
    <!DOCTYPE html>
    <html>
      <head>
        <title>Replace DNS with IP</title>
      </head>
      <body>
        <form id="form">
          <label for="ip">Enter IP:</label>
          <input type="text" id="ip" name="ip" required />
          <br />
          <label for="category">Select Category:</label>
          <select id="category" name="category">
            ${dropdownOptions}
          </select>
          <br />
          <button type="button" id="submit">Submit</button>
        </form>
        <pre id="result"></pre>
        <script>
          document.getElementById("submit").addEventListener("click", async () => {
            const ip = document.getElementById("ip").value;
            const category = document.getElementById("category").value;
            const response = await fetch("/", {
              method: "POST",
              headers: { "Content-Type": "application/json" },
              body: JSON.stringify({ ip, category }),
            });
            const result = await response.text();
            document.getElementById("result").textContent = result;
          });
        </script>
      </body>
    </html>
    `,
    {
      headers: { "Content-Type": "text/html" },
    }
  );
}
