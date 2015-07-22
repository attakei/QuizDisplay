runSequence = require('run-sequence')
gulp   = require('gulp')
coffee = require('gulp-coffee')
jade = require('gulp-jade')
react = require('gulp-react')
webpack = require('webpack-stream')

config = require('./config')


gulp.task 'default', ['build']


gulp.task 'develop', (callback) ->
  config.webpack.entry = config.dest.compile + '/sub.js'
  runSequence(
    'build',
    callback
  )

gulp.task 'watch', ['develop'], (callback) ->
  gulp.watch('./src/**', ['develop']);


gulp.task 'build', (callback) ->
  runSequence(
    'compile',
    ['webpack', 'copy:index', 'copy:vendor'],
    callback
  )

gulp.task 'compile', (callback) ->
  runSequence(
    [
      'compile:jsx'
      ,'compile:coffee'
      ,'compile:jade'
    ]
    callback
  )

gulp.task 'compile:jsx', ->
  gulp.src('src/**/*.jsx')
    .pipe(react())
    .pipe(gulp.dest(config.dest.compile))

gulp.task 'compile:coffee', ->
  gulp.src('src/**/*.coffee')
    .pipe(coffee())
    .pipe(gulp.dest(config.dest.compile))

gulp.task 'compile:jade', ->
  gulp.src('src/*.jade')
    .pipe(jade())
    .pipe(gulp.dest(config.dest.compile))
  gulp.src('src/**/*.jade')
    .pipe(gulp.dest(config.dest.compile))


gulp.task 'copy:index', ->
  gulp.src('src/index.html')
    .pipe(gulp.dest(config.dest.package))

gulp.task 'copy:vendor', ->
  gulp.src('vendor/*', { base: 'vendor' })
    .pipe(gulp.dest(config.dest.package + '/lib'))

gulp.task 'webpack', ->
  gulp.src(config.webpack.entry)
    .pipe(webpack(config.webpack))
    .pipe(gulp.dest(config.dest.package))
