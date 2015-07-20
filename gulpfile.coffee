runSequence = require('run-sequence')
gulp   = require('gulp')
coffee = require('gulp-coffee')
react = require('gulp-react')
webpack = require('webpack-stream')


config = require('./config')


gulp.task 'default', ['build']

gulp.task 'build', (callback) ->
  runSequence(
    'compile',
    'webpack',
    callback
  )

gulp.task 'compile', (callback) ->
  runSequence(
    [
      'compile:jsx'
      ,'compile:coffee'
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

gulp.task 'webpack', ->
  gulp.src(config.webpack.entry)
    .pipe(webpack(config.webpack))
    .pipe(gulp.dest(config.dest.package))
