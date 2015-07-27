gulp   = require('gulp')
config = require('../config')


gulp.task 'watch', (callback) ->
  gulp.watch('./src/**', ['develop'])
