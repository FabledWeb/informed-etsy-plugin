module.exports = (grunt) ->
  grunt.loadTasks("tasks")
  grunt.loadNpmTasks("grunt-jasmine-bundle")

  grunt.initConfig
    spec:
      unit:
        specs: "test/**/*.{js,coffee}"

  grunt.registerTask("default", ["spec:unit"])

