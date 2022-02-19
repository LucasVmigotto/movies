import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [vue()],
  server: {
    host: process.env.VITE_HOST || '0.0.0.0',
    port: process.env.VITE_PORT || 4001
  },
  build: {
    outDir: 'movies'
  }
})
