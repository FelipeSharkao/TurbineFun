import coffee from 'rollup-plugin-coffee-script'
import coffeelint from './vite/coffeelint'
import { defineConfig } from 'vite'

export default defineConfig({
  build: { outDir: 'build' },
  plugins: [coffeelint(), coffee()],
  optimizeDeps: {
    exclude:
      process.env.NODE_ENV !== 'production'
        ? ['tailwindcss', '@funkia/hareactive']
        : undefined,
  },
})
