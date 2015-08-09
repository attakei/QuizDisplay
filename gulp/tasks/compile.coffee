gulp   = require('gulp')
stripDebug = require('gulp-strip-debug')
less = require('gulp-less')
coffee = require('gulp-coffee')
jade = require('gulp-jade')
reactJade = require('@mizchi/gulp-react-jade')
jsonTransform = require('gulp-json-transform')

config = require('../config')


gulp.task 'compile', (callback) ->
  runSequence = require('run-sequence')
  runSequence(
    ['compile:jade:js' ,'compile:coffee', 'compile:less' ,'compile:jade:html'],
    callback
  )

gulp.task 'compile:coffee', ->
  gPipe = gulp.src('src/**/*.coffee').pipe(coffee())
  if config.production
    gPipe = gPipe.pipe(stripDebug())
  gPipe.pipe(gulp.dest(config.dest.compile))

gulp.task 'compile:jade:js', ->
  gulp.src(['src/**/*.jade', '!src/html/**/*.jade'])
  .pipe(reactJade())
  .pipe(gulp.dest(config.dest.compile))

gulp.task 'compile:jade:html', ->
  gulp.src('src/html/**/*.jade')
  .pipe(jade())
  .pipe(gulp.dest(config.dest.compile + '/html'))

gulp.task 'compile:less', ->
  gulp.src('src/css/**/*.less')
  .pipe(less())
  .pipe(gulp.dest(config.dest.compile + '/css'))

gulp.task 'compile:packageJson', ->
  gulp.src('package.json')
    .pipe(jsonTransform((data) ->
      ret = {}
      for key, val of data
        if key in config.packageJson
          ret[key] = val
      ret
    ))
    .pipe(gulp.dest(config.dest.compile))

gulp.task 'copy:index', ->
  gulp.src(config.dest.compile + '/html/index.html')
  .pipe(gulp.dest(config.dest.package))

gulp.task 'copy:resource', ->
  gulp.src('resource/**/*') #, { base: 'resource' })
  .pipe(gulp.dest(config.dest.package))

gulp.task 'copy:css', ->
  gulp.src(config.dest.compile+'/css/layout.css')
  .pipe(gulp.dest(config.dest.package))
