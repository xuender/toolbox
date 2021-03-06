module.exports = (grunt)->
  grunt.loadNpmTasks('grunt-contrib-clean')
  grunt.loadNpmTasks('grunt-contrib-concat')
  grunt.loadNpmTasks('grunt-contrib-uglify')
  grunt.loadNpmTasks('grunt-contrib-watch')
  grunt.loadNpmTasks('grunt-contrib-copy')
  grunt.loadNpmTasks('grunt-karma')
  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-coffeelint')
  grunt.loadNpmTasks('grunt-contrib-cssmin')
  grunt.loadNpmTasks('grunt-contrib-htmlmin')
  grunt.loadNpmTasks('grunt-shell')
  grunt.loadNpmTasks('grunt-bumpx')
  grunt.loadNpmTasks('grunt-contrib-compress')
  grunt.loadNpmTasks('grunt-manifest')

  grunt.initConfig(
    pkg:
      grunt.file.readJSON('package.json')
    clean:
      dist: ['dist']
    bump:
      options:
        part: 'patch'
      files: [ 'package.json', 'bower.json', 'src/manifest.json' ]
    copy:
      angular:
        files: [
          cwd: 'bower_components/angular/'
          src: [
            'angular.min.js'
            'angular.min.js.map'
          ]
          dest: 'dist/js'
          expand: true
          filter: 'isFile'
        ]
      angularBootstrap:
        files: [
          cwd: 'bower_components/angular-bootstrap/'
          src: [
            'ui-bootstrap-tpls.min.js'
          ]
          dest: 'dist/js'
          expand: true
          filter: 'isFile'
        ]
      jquery:
        files: [
          cwd: 'bower_components/jquery/'
          src: [
            'jquery.min.js'
            'jquery.min.map'
          ]
          dest: 'dist/js'
          expand: true
          filter: 'isFile'
        ]
      analytics:
        files: [
          cwd: 'bower_components/chrome-platform-analytics'
          src: [
            'google-analytics-bundle.js'
          ]
          dest: 'dist/js'
          expand: true
          filter: 'isFile'
        ]
      hotkey:
        files: [
          cwd: 'bower_components/ng-hotkey/'
          src: [
            'hotkey.min.js'
          ]
          dest: 'dist/js'
          expand: true
          filter: 'isFile'
        ]
      crypto:
        files: [
          cwd: 'bower_components/crypto-js/build/components'
          src: [
            'core-min.js'
            'md5-min.js'
            'sha1-min.js'
          ]
          dest: 'dist/js'
          expand: true
          filter: 'isFile'
        ]
      beautify:
        files: [
          cwd: 'bower_components/js-beautify/js/lib'
          src: [
            'beautify-css.js'
            'beautify-html.js'
            'beautify.js'
          ]
          dest: 'dist/js'
          expand: true
          filter: 'isFile'
        ]
      bootstrap:
        files: [
          cwd: 'bower_components/bootstrap/dist/'
          src: [
            'css/bootstrap.min.css'
            'js/bootstrap.min.js'
            'fonts/*.woff'
          ]
          dest: 'dist'
          expand: true
          filter: 'isFile'
        ]
      root:
        files: [
          cwd: 'src'
          src: [
            'manifest.json'
          ]
          dest: 'dist'
          expand: true
          filter: 'isFile'
        ]
      i18n:
        files: [
          cwd: 'src'
          src: '_locales/**'
          dest: 'dist'
          expand: true
          filter: 'isFile'
        ]
      img:
        files: [
          cwd: 'src'
          src: 'img/**'
          dest: 'dist'
          expand: true
          filter: 'isFile'
        ]
    coffee:
      options:
        bare: true
      main:
        files:
          'dist/js/main.min.js': [
            'src/js/toolbox.coffee'
            'src/js/command.coffee'
            'src/js/sort.coffee'
            'src/js/trim.coffee'
            'src/js/unique.coffee'
            'src/js/hash.coffee'
            'src/js/sql.coffee'
            'src/js/beautify.coffee'
            'src/js/about.coffee'
            'src/js/index.coffee'
          ]
      background:
        files:
          'dist/js/background.js': [
            'src/js/background.coffee'
          ]
    uglify:
      main:
        files:
          'dist/js/main.min.js': [
            'dist/js/main.min.js'
          ]
      background:
        files:
          'dist/js/background.js': [
            'dist/js/background.js'
          ]
    htmlmin:
      dist:
        options:
          removeComments: true,
          collapseWhitespace: true
        files:
          'dist/index.html': 'src/index.html'
          'dist/about.html': 'src/about.html'
    cssmin:
      toolbox:
        expand: true
        cwd: 'src/css/'
        src: ['*.css', '!*.min.css'],
        dest: 'dist/css/',
        ext: '.min.css'
    watch:
      json:
        files: [
          'src/**/*.json'
        ]
        tasks: [
          'copy:root'
          'copy:i18n'
        ]
      html:
        files: [
          'src/*.html'
        ]
        tasks: ['htmlmin']
      css:
        files: [
          'src/**/*.css'
        ]
        tasks: ['cssmin']
      coffee:
        files: [
          'src/**/*.coffee'
        ]
        tasks: ['coffee']
    compress:
      google:
        options:
          archive: 'dist/toolbox.zip'
        files: [
          {expand: true, cwd: 'dist', src: '**/*', dest: '/'}
        ]
    karma:
      options:
        configFile: 'karma.conf.js'
      dev:
        colors: true,
      travis:
        singleRun: true
        autoWatch: false
  )
  grunt.registerTask('test', ['karma'])
  grunt.registerTask('dev', [
    'clean'
    'copy',
    'htmlmin'
    'cssmin'
    'coffee'
  ])
  grunt.registerTask('dist', [
    'dev'
    'uglify'
    'compress'
  ])
  grunt.registerTask('deploy', [
    'bump'
    'dist'
  ])
  grunt.registerTask('travis', 'travis test', ['karma:travis'])
  grunt.registerTask('default', ['dist'])
