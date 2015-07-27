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

gulp.task 'watch', (callback) ->
gulp.watch('./src/**', ['develop'])
