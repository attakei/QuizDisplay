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


module.exports = config
