gulp   = require('gulp')
stripDebug = require('gulp-strip-debug')
less = require('gulp-less')
coffee = require('gulp-coffee')
jade = require('gulp-jade')
react = require('gulp-react')

config = require('../config')


gulp.task 'compile', (callback) ->
  runSequence = require('run-sequence')
  runSequence(
    ['compile:jsx' ,'compile:coffee', 'compile:less' ,'compile:jade', 'compile:jade-raw'],
    callback
  )

gulp.task 'compile:jsx', ->
  gulp.src('src/**/*.jsx')
  .pipe(react())
  .pipe(gulp.dest(config.dest.compile))

gulp.task 'compile:coffee', ->
  gPipe = gulp.src('src/**/*.coffee').pipe(coffee())
  if config.production
    gPipe = gPipe.pipe(stripDebug())
  gPipe.pipe(gulp.dest(config.dest.compile))

gulp.task 'compile:jade-raw', ->
  gulp.src('src/**/*.jade')
  .pipe(gulp.dest(config.dest.compile))

gulp.task 'compile:jade', ->
  gulp.src('src/html/**/*.jade')
  .pipe(jade())
  .pipe(gulp.dest(config.dest.compile + '/html'))

gulp.task 'compile:less', ->
  gulp.src('src/css/**/*.less')
  .pipe(less())
  .pipe(gulp.dest(config.dest.compile + '/css'))

gulp.task 'copy:index', ->
  gulp.src(config.dest.compile + '/html/index.html')
  .pipe(gulp.dest(config.dest.package))

gulp.task 'copy:resource', ->
  gulp.src('resource/**/*') #, { base: 'resource' })
  .pipe(gulp.dest(config.dest.package))

gulp.task 'copy:css', ->
  gulp.src(config.dest.compile+'/css/layout.css')
  .pipe(gulp.dest(config.dest.package))
