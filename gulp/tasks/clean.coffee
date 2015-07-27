runSequence = require('run-sequence')
del         = require('del')
gulp        = require('gulp')
config      = require('../config')


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
