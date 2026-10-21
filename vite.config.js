import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";
export default defineConfig({
  define: { __DRIKA_BUILD_ID__: JSON.stringify(String(Date.now())) },
  plugins: [react()],
  build: { target: "es2022", sourcemap: false },
  server: { middlewareMode: true },
});
