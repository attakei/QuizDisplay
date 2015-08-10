config =
  production: false
  src: './src'
  dest:
    compile: './lib'
    package: './public'

config.webpack =
    entry: config.dest.compile + '/main.js'
    output:
      filename: 'main.js'
    resolve:
      extensions: ['', '.js']

config.electron =
  src: './public'
  packageJson: require('../package.json')
  release: './dist'
  cache: './cache'
  version: 'v0.30.2'
  # packaging: true
  platforms: ['darwin-x64']  # ['win32-ia32', 'darwin-x64'],
  platformResources:
    darwin:
      CFBundleDisplayName: 'QuizDisplay'
      CFBundleIdentifier: 'QuizDisplay'
      CFBundleName: 'QuizDisplay'
      CFBundleVersion: '0.0.1'
      # icon: 'gulp-electron.icns'

config.packageJson = [
  'name'
  'version'
  'main'
]

module.exports = config
