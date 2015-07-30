gulp        = require('gulp')
electron    = require('gulp-electron')


config = require('../config')


gulp.task 'electron', () ->
  gulp.src('')
    .pipe(electron(config.electron))
    .pipe(gulp.dest(''))
