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
    SRC_IMG: './src/images/',
    DIST_IMG: './src/webp-dist',
    CSS: './**/*.css'
};

// Gulp Tasks
// =========================================================

// delete css ------------------------------------
function clean() {
    log.info('-------> Cleaning Styles');
    return del(PATHS.CSS);
}

// compile styles ------------------------------------
function compileStyles() {
    return src(PATHS.SASS.SRC)
        .pipe(plugins.sass())
        .pipe(plugins.prefixer())
        .pipe(dest(PATHS.SASS.OUTPUT));
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
function webPjpg() {
    return src(PATHS.SRC_IMG + '*.{jpg,jpeg}')
        .pipe(plugins.webp({
            quality: 65,
            // lossless: true,
            method: 4,
            metadata: 'all'
        }))
        .pipe(dest(PATHS.DIST_IMG));
}

// function webPpng() {
//     return src(PATHS.SRC_IMG + '*.{png}')
//         .pipe(plugins.webp({
//             // quality: 65,
//             // lossless: true
//             // method: 4,
//             // metadata: 'all'
//         }))
//         .pipe(dest(PATHS.DIST_IMG));
// }

// gulp testing message ------------------------------------
function endMsg(cb) {
    log.info('-------> Styles Reloaded');
    cb();
}

function imgMsg(cb) {
    log.info('-------> Images Converted');
    cb();
}

// Default Gulp Task
// =========================================================
exports.default = function() {
    watch(PATHS.SASS.ALL, {
        ignoreInitial: false
    }, series(clean, compileStyles, minify, endMsg));
    watch(PATHS.SRC_IMG, {
        ignoreInitial: false
    }, series(webPjpg, imgMsg));
};

// End