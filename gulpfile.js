// =========================================================
// gulpfile.js
// =========================================================
const {
    series,
    parallel,
    watch,
    src,
    dest
} = require('gulp'),
    del = require('del'),
    log = require('fancy-log'),
    plugins = require('gulp-load-plugins')({
        rename: {
            'gulp-jsbeautifier': 'beauty',
            'gulp-autoprefixer': 'prefixer'
        }
    });

// configs -------------------------------------------------
const PATHS = {
    SASS: {
        ALL: './**/*.{scss,sass}',
        SRC: './src/**/*.{scss,sass}',
        OUTPUT: './src/css',
        DIST: './dist'
        // OPTS: {
        //
        // }
    },
    SRC_IMG: './convert/images/',
    DIST_IMG: './convert/webp-dist',
    CSS: './**/*.css',
    JS: {
        SRC: '../*(desktop|mobile)/*.js',
        DIST: './dist/'
    }
};

// Gulp Tasks
// =========================================================

// delete css ------------------------------------
function cleanCSS() {
    log.info('-------> Cleaning Styles');
    return del(PATHS.CSS);
}

// delete js ------------------------------------
function cleanJS() {
    log.info('-------> Cleaning JavaScript');
    return del(PATHS.JS.DIST + '*.js');
}

// compile styles ------------------------------------
function compileStyles() {
    return src(PATHS.SASS.SRC)
        .pipe(plugins.dartSass().on('error', plugins.dartSass.logError))
        .pipe(plugins.prefixer())
        .pipe(dest(PATHS.SASS.OUTPUT));
}

// compile scripts ----------------------------------
function compileScripts() {
    return src(PATHS.JS.SRC)
        .pipe(plugins.minify({
            ext: {
                min: '.min.js'
            }
        }))
        .pipe(dest(PATHS.JS.DIST))
}

// minify styles ------------------------------------
function minify() {
    return src(PATHS.SASS.OUTPUT + '/*.css')
        .pipe(plugins.beauty({
            indent_size: 4
        }))
        .pipe(plugins.cleanCss({ // https://github.com/jakubpawlowicz/clean-css
            format: {
                breaks: {
                    afterBlockBegins: true,
                    afterBlockEnds: true,
                    afterRuleBegins: false,
                    afterRuleEnds: true,
                    afterComment: true
                },
                spaces: {
                    beforeBlockBegins: true,
                    beforeValue: false
                }
            }
        }))
        .pipe(dest(PATHS.SASS.DIST));
}

// Convert images to WebP ------------------------------------
function webP() {
    return src(PATHS.SRC_IMG + '*.{jpg,jpeg,png}')
        .pipe(plugins.webp({
            quality: 65,
            // lossless: true,
            method: 4,
            metadata: 'all'
        }))
        .pipe(dest(PATHS.DIST_IMG));
}

// gulp testing message ------------------------------------
function endMsg(cb) {
    log.info('-------> Styles Reloaded');
    cb();
}

function endJSMsg(cb) {
    log.info('-------> Scripts Reloaded');
    cb();
}

function imgMsg(cb) {
    log.info('-------> Images Converted');
    cb();
}

// Default Gulp Task
// =========================================================
exports.default = function () {
    watch(PATHS.SASS.ALL, {
        ignoreInitial: false
    }, series(cleanCSS, compileStyles, minify, compileScripts, endMsg));
    watch(PATHS.JS.SRC, {
        ignoreInitial: false
    }, series(cleanJS, compileScripts, endJSMsg))
    watch(PATHS.SRC_IMG, {
        ignoreInitial: false
    }, series(webP, imgMsg));
};

// End