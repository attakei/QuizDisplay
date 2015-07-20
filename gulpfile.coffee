gulp   = require('gulp')
coffee = require('gulp-coffee')
react = require('gulp-react')
webpack = require('webpack-stream')


gulp.task 'default', ['build']

gulp.task 'build', [
  'compile',
  'webpack',
]

gulp.task 'compile', [
  'compile:jsx',
  'compile:coffee',
]

gulp.task 'compile:jsx', ->
  gulp.src('src/**/*.jsx')
    .pipe(react())
    .pipe(gulp.dest('lib'))

gulp.task 'compile:coffee', ->
  gulp.src('src/**/*.coffee')
    .pipe(coffee())
    .pipe(gulp.dest('lib'))


gulp.task 'webpack', ->
  config =
    entry: './lib/main.js'
    output:
      filename: 'main.js'
    resolve:
      extensions: ['', '.js']
  gulp.src('./lib/main.js')
    .pipe(webpack(config))
    .pipe(gulp.dest('./app'))
