runSequence = require('run-sequence')
gulp        = require('gulp')
uglify      = require("gulp-uglify")
webpack     = require('webpack-stream')
electron    = require('gulp-electron')
config      = require('../config')


gulp.task 'electron', (callback) ->
  runSequence(
    'prod',
    'atom:json',
    'atom:app',
    callback
  )

gulp.task 'develop', (callback) ->
  config.webpack.entry = config.dest.compile + '/sub.js'
  runSequence(
    'build',
    callback
  )

gulp.task 'prod', (callback) ->
  config.production = true
  runSequence(
    'clean',
    'build',
    callback
  )

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


gulp.task 'atom:json', (callback) ->
  gulp.src([
      config.dest.compile + '/' + 'package.json',
      config.dest.compile + '/' + config.electron.packageJson.main
    ])
    .pipe(gulp.dest(config.dest.package))


gulp.task 'atom:app', (callback) ->
  gulp.src('')
    .pipe(electron(config.electron))
    .pipe(gulp.dest(''))
