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
    'build'
  )

gulp.task 'mocha', (callback) ->
  gulp.src(['test/**/.js', 'test/**/*coffee'], { read: false })
    .pipe(mocha({ reporter: 'list'}))
    # .on('error', gutil.log)


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

gulp.task 'compile', (callback) ->
  runSequence(
    ['compile:jsx' ,'compile:coffee', 'compile:less' ,'compile:jade'],
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

gulp.task 'compile:jade', ->
  gulp.src('src/**/*.jade')
    .pipe(gulp.dest(config.dest.compile))

gulp.task 'compile:less', ->
  gulp.src('src/**/*.less')
    .pipe(less())
    .pipe(gulp.dest(config.dest.compile))

gulp.task 'copy:index', ->
  gulp.src('src/index.html')
    .pipe(gulp.dest(config.dest.package))

gulp.task 'copy:resource', ->
  gulp.src('resource/*') #, { base: 'resource' })
    .pipe(gulp.dest(config.dest.package))

gulp.task 'copy:css', ->
  gulp.src(config.dest.compile+'/layout.css')
    .pipe(gulp.dest(config.dest.package))

gulp.task 'webpack', ->
  gPipe = gulp.src(config.webpack.entry).pipe(webpack(config.webpack))
  if config.production
    gPipe = gPipe.pipe(uglify())
  gPipe.pipe(gulp.dest(config.dest.package))
