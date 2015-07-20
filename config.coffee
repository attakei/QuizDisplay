config =
  src: './src'
  dest:
    compile: './lib'
    package: './app'

config.webpack =
    entry: config.dest.compile + '/main.js'
    output:
      filename: 'main.js'
    resolve:
      extensions: ['', '.js']


module.exports = config
