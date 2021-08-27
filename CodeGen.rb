#!/usr/bin/ruby

require 'yaml'
require 'optparse'

def parseArgs()
    options = {}
    OptionParser.new do |opt|
        opt.on('--configPath config') { |o| options[:configPath] = o }
        opt.on('--template template') { |o| options[:template] = o }
        opt.on('--output output') { |o| options[:output] = o }
    end.parse!
    options
end

def getCMDString(options)
    if options[:configPath].nil?
        raise StandardError, "Config path is missing!"
    end

    if options[:template].nil?
        raise StandardError, "Template argument is missing"
    end

    if options[:output].nil?
        raise StandardError, "Output argument is missing"
    end
    configFile = File.expand_path("./serviceConfig.yaml", options[:configPath])

    config = YAML.load_file(configFile)
    sources = config["sources"]

    if sources.nil?
        raise StandardError, "Sources is missing in config file"
    end

    resolvedSources = sources.map { |item| File.expand_path(item, options[:configPath]) }
    sourcesString = "--sources " + resolvedSources.join("--sources")
    
    "sourcery #{sourcesString} --templates #{options[:template]} --output #{options[:output]}"
end


def runCodeGen()
    options = parseArgs()

    puts options

    cmdString = getCMDString(options)

    puts cmdString

    system(cmdString)
end

runCodeGen()