runSequence = require('run-sequence')
gulp        = require('gulp')
uglify      = require("gulp-uglify")
webpack     = require('webpack-stream')
config      = require('../config')


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
    'electron',
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

gulp.task 'electron', (callback) ->
  gulp.src(config.dest.compile + '/runner.js')
    .pipe(gulp.dest(config.dest.package))
  gulp.src('./package.json')
    .pipe(gulp.dest(config.dest.package))
