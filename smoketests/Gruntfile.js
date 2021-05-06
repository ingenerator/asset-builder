module.exports = function (grunt) {
    grunt.initConfig({
        concat: {
            options: {
                separator: ';'
            },
            base_js: {
                src:    [
                    'src/js/1.js',
                    'src/js/2.js'
                ],
                dest:   'compiled/js/base_js.js',
                nonull: true
            },
        },
        copy:   {
            stuff: {
                cwd:    'src/assets',
                expand: true,
                src:    '*',
                dest:   'compiled/copied/'
            }
        },
        jshint: {
            options:    {
                // Require braces round all blocks
                curly: true,
                // No ==
                eqeqeq: true,
                // Init vars at top of functions (functions can be defined later)
                latedef: 'nofunc',
                // No deep nesting
                maxdepth: 4,
                // Require strict mode
                strict: true,
                // No trailing whitespace
                trailing: true,
                // Warn on undefined variables
                undef: true,
                // Warn on unused variables
                unused: true,
                // Set environment for browser
                browser: true,
                // Define standard jquery globals
                jquery: true,
            },
            project_js: {
                options: {
                    // Allow console.log for our smoketests
                    devel:   true,
                    globals: {},
                    ignores: []
                },
                src:     [
                    'compiled/js/*.js'
                ]
            },
            invalid_js: {
                src: [
                    'src/js/jshint-invalid.js'
                ]
            }
        },
        less:   {
            site: {
                options: {
                    paths:             [
                        'src/less',
                        'src/vendorless'
                    ],
                    compress:          true,
                    sourceMap:         true,
                    sourceMapFilename: 'compiled/site.css.map',
                    sourceMapURL:      'site.css.map'
                },
                files:   {
                    'compiled/site.css': 'src/less/site.less',
                }
            },
        },
        uglify: {
            options: {
                banner:                  '/*! <%= grunt.template.today("dd-mm-yyyy") %> */\n',
                sourceMap:               true,
                sourceMapIncludeSources: true
            },
            js:      {
                files: {
                    'compiled/base_js.min.js': ['<%= concat.base_js.dest %>'],
                }
            }
        },
    });

    grunt.loadNpmTasks('grunt-contrib-uglify');
    grunt.loadNpmTasks('grunt-contrib-less');
    grunt.loadNpmTasks('grunt-contrib-copy');
    grunt.loadNpmTasks('grunt-contrib-concat');
    grunt.loadNpmTasks('grunt-contrib-jshint');

    grunt.registerTask('compile-assets', ['copy', 'compile:js', 'less']);
    grunt.registerTask('compile:js', ['concat:base_js', 'jshint:project_js', 'uglify:js']);
};
