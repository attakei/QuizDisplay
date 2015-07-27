runSequence = require('run-sequence')
del = require('del')
gulp   = require('gulp')
stripDebug = require('gulp-strip-debug')
less = require('gulp-less')
coffee = require('gulp-coffee')
jade = require('gulp-jade')
react = require('gulp-react')
mocha = require('gulp-mocha')
uglify = require("gulp-uglify")
webpack = require('webpack-stream')

config = require('./config')


gulp.task 'default', ['build']


gulp.task 'prod', (callback) ->
  config.production = true
  runSequence(
    'clean',
    'build'
  )


gulp.task 'clean', (callback) ->
  runSequence(
    ['clean:dist', 'clean:compiled'],
    callback
  )

gulp.task 'clean:dist', (callback) ->
  del(
    [config.dest.package],
    callback
  )

gulp.task 'clean:compiled', (callback) ->
  del(
    [config.dest.compile],
    callback
  )

gulp.task 'develop', (callback) ->
  config.webpack.entry = config.dest.compile + '/sub.js'
  runSequence(
    'build',
    callback
  )

gulp.task 'watch', (callback) ->
  gulp.watch('./src/**', ['develop'])


gulp.task 'build', (callback) ->
  runSequence(
    'compile',
    ['webpack', 'copy:index', 'copy:resource', 'copy:css'],
    callback
  )


gulp.task 'webpack', ->
  gPipe = gulp.src(config.webpack.entry).pipe(webpack(config.webpack))
  if config.production
    gPipe = gPipe.pipe(uglify())
  gPipe.pipe(gulp.dest(config.dest.package))
