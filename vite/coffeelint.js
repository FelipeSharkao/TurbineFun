import * as path from 'path'

import coffeelint from '@coffeelint/cli'
import { createFilter } from '@rollup/pluginutils'
import { readFileSync } from 'fs'

export default function eslintPlugin(options = {}) {
  const defaultOptions = {
    include: ['src/**/*.coffee', 'src/**/*.csjx'],
    throwOnWarning: true,
    throwOnError: true,
    configFile: './coffeelint.json',
  }
  const opts = { ...defaultOptions, ...options }
  const filter = createFilter(opts.include, opts.exclude || /node_modules/)

  const configFile = path
    .relative(process.cwd(), opts.configFile)
    .split(path.sep)
    .join('/')
  const config = JSON.parse(readFileSync(path.join(process.cwd(), configFile)))

  return {
    name: 'vite:coffeelint',
    async transform(input, id) {
      if (!filter(id)) return null

      const data = coffeelint.lint(input, { ...config, ...options })

      for (const error of data) {
        const position = { column: error.columnNumber, line: error.lineNumber }
        const message =
          '\n' +
          `coffeelint(${error.name}): ${error.message}` +
          (error.context ? `. ${error.context}` : '')

        switch (error.level) {
          case 'warn':
            if (opts.throwOnWarning) this.warn(message, position)
            break
          case 'error':
            if (opts.throwOnError) this.error(message, position)
            break
        }
      }

      return null
    },
  }
}
