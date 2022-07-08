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
        DIST: './dist'
        // OPTS: {
        //
        // }
    },
    IMG: {
        SRC: './convert-images/',
        DIST: '../images'
    },
    CSS: './**/*.css',
    JS: {
        SRC: './convert-script/',
        DIST: '../script/'
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
    return del(PATHS.JS.SRC + '*.js');
}

// delete images ------------------------------------
function cleanIMG() {
    log.info('-------> Cleaning Source Images');
    return del(PATHS.IMG.SRC + '*.{jpg,jpeg,png}');
}

// compile styles ------------------------------------
function compileStyles() {
    return src(PATHS.SASS.SRC)
        .pipe(plugins.dartSass().on('error', plugins.dartSass.logError))
        .pipe(plugins.prefixer())
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

// compile scripts ----------------------------------
function compileScripts() {
    return src(PATHS.JS.SRC + '*.js')
        .pipe(plugins.minify({
            ext: {
                src: '-debug.js',
                min: '.min.js'
            }
        }))
        .pipe(dest(PATHS.JS.DIST))
}

// Convert images to WebP ------------------------------------
function webP() {
    return src(PATHS.IMG.SRC + '*.{jpg,jpeg,png}')
        .pipe(dest(PATHS.IMG.DIST))
        .pipe(plugins.webp({
            quality: 80,
            lossless: false,
            method: 4,
            metadata: 'all'
        }))
        .pipe(dest(PATHS.IMG.DIST));
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
    log.info('-------> Images Converted and Moved');
    cb();
}

// Default Gulp Task
// =========================================================
exports.default = function () {
    watch(PATHS.SASS.ALL, {
        ignoreInitial: false
    }, series(cleanCSS, compileStyles, compileScripts, endMsg));
    watch(PATHS.JS.SRC, {
        ignoreInitial: false
    }, series(compileScripts, cleanJS, endJSMsg))
    watch(PATHS.IMG.SRC, {
        ignoreInitial: false
    }, series(webP, cleanIMG, imgMsg));
};

// End