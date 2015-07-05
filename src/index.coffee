module.exports = class HaxeBrunchCompiler
    brunchPlugin: yes
    type: 'javascript'

    constructor: (@config) ->
        cfg = @config.plugins?.haxe ? {}
        @extension = cfg.extension ? "hxml"
        null

    compile: (data, path, callback) ->
        exec = require('child_process').exec
        fs   = require('fs')
        child = exec "haxe #{path} -js /tmp/test.js", (err, stdout, stderr) ->
            if err?
                console.log("Failed to compile #{path}: ", err)
                callback err
            else
                console.log("errors: #{stderr}")
                compiled= fs.readFileSync("/tmp/test.js")
                if !compiled
                    callback "failed to read compiled file"
                else
                    callback null, {
                        data: compiled
                    }
