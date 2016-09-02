var gulp = require('gulp'),
	autoprefixer = require('autoprefixer'),
	folders = require('gulp-folders'),
	imagemin = require('gulp-imagemin'),
	imageResize = require('gulp-image-resize'),
	jsonlint = require('gulp-jsonlint'),
	path = require('path'),
	postcss = require('gulp-postcss'),
	print = require('gulp-print');

var site = '/site/';

gulp.task('css', folders(site, function(folder) {
	var processors = [
		autoprefixer({
			browsers: ['last 2 versions', '> 5%']
		})
	];

	return gulp.src(path.join(site, folder, 'assets', 'css', '*.css'))
		.pipe(print())
		.pipe(postcss(processors))
		.pipe(gulp.dest(''))
}));

gulp.task('img:resize', folders(site, function(folder) {
	var paths = [
		path.join(site, folder, 'assets', 'img', '*.*'),
		path.join(site, folder, 'images', '*.*'),
		path.join(site, folder, 'images', '**', '*.*')
	]
	return gulp.src(paths)
		.pipe(imageResize({
			width: 1024,
			upscale : false
		}))
		.pipe(print())
		.pipe(gulp.dest(path.join(site, 'images')));
}));

gulp.task('img:minify', ['img:resize'], folders(site, function(folder) {
	var paths = [
		path.join(site, folder, 'assets', 'img', '*.*'),
		path.join(site, folder, 'images', '*.*'),
		path.join(site, folder, 'images', '**', '*.*')
	]
	return gulp.src(paths)
		.pipe(imagemin({
			progressive: true,
			svgoPlugins: [{
				removeViewBox: false
			}],
		}))
		.pipe(print())
		.pipe(gulp.dest(path.join(site, 'images')));
}));

gulp.task('jsonlint', function() {
	gulp.src('./*.json')
		.pipe(print())
		.pipe(jsonlint())
		.pipe(jsonlint.failAfterError())
});

gulp.task('post-process', ['css', 'img:minify'])
gulp.task('lint', ['jsonlint'])
