gulp   = require('gulp')
config = require('../config')


gulp.task 'watch', (callback) ->
  gulp.watch('./src/**', ['build'])

gulp.task 'watch:develop', (callback) ->
  gulp.watch('./src/**', ['develop'])

gulp.task 'watch:mocha', ->
  gulp.watch ['./src/**/*', './test/**/*'], ['mocha']
