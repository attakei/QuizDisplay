runSequence = require('run-sequence')
gulp   = require('gulp')
less = require('gulp-less')
coffee = require('gulp-coffee')
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
    ['webpack', 'copy:index', 'copy:vendor', 'copy:css'],
    callback
  )

gulp.task 'compile', (callback) ->
  runSequence(
    ['compile:jsx' ,'compile:coffee', 'compile:less'],
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

gulp.task 'compile:less', ->
  gulp.src('src/**/*.less')
    .pipe(less())
    .pipe(gulp.dest(config.dest.compile))

gulp.task 'copy:index', ->
  gulp.src('src/index.html')
    .pipe(gulp.dest(config.dest.package))

gulp.task 'copy:vendor', ->
  gulp.src('vendor/*', { base: 'vendor' })
    .pipe(gulp.dest(config.dest.package + '/lib'))

gulp.task 'copy:css', ->
  gulp.src(config.dest.compile+'/layout.css')
    .pipe(gulp.dest(config.dest.package))

gulp.task 'webpack', ->
  gulp.src(config.webpack.entry)
    .pipe(webpack(config.webpack))
    .pipe(gulp.dest(config.dest.package))
