import coffee from 'rollup-plugin-coffee-script'
import { defineConfig } from 'vite'

export default defineConfig({
  build: { outDir: 'build' },
  plugins: [coffee()],
  optimizeDeps: {
    exclude:
      process.env.NODE_ENV !== 'production'
        ? ['tailwindcss', '@funkia/hareactive']
        : undefined,
  },
})
