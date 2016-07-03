require 'hashie'
require 'css_parser'
require 'nokogiri'

class Config < Hash
	include Hashie::Extensions::MethodAccessWithOverride
end
	

class CSSDeadClass
	def self.config
		@_config ||= Config.new
	end
	def self.option(key, default=nil, description=nil, options={})
		self.config[key] = Config.new(default: default, description: description, options: {})
	end
	option :css_files, [], "CSS Files to Scan"
	option :html_files, [], "HTML Files to Scan"
	option :classes_to_keep, [], "Classes to Keep Regardless of Presence in CSS Files"
	
	def initialize(opts={})
		@options = self.class.config.dup
		opts.each do |k, v|
			@options[k] = v
		end
	end
	
	def parse
		cssSelectors = []
		cssFiles = @options.css_files
		htmlFiles = @options.html_files
		classesToKeep = @options.classes_to_keep
		if cssFiles.length > 0
			parser = CssParser::Parser.new
			cssFiles.each do |cssFile|
				parser.load_file!(cssFile)
			end	
			parser.each_selector(:screen).each do |rule|
				rule = rule[:rules]
				rule.selectors.each do |segment|
					segment.split(/(?: |\+|>)/).each do |r|
						next if r.include? ":"
						if(r[0] == ".")
							cssSelectors.push(r)
						elsif(r.include? ".")
							s = r.split(".")
							s.shift
							s.each { |v| cssSelectors.push('.' + v)}
						end
					end
				end
			end
			cssSelectors.uniq!
		end
		if cssSelectors.length > 0
			htmlFiles.each do |htmlFile|
				htmlDoc = Nokogiri::HTML(IO.read(htmlFile))
				htmlDoc.css('*').each do |node|
					next if node.attributes.nil? or node.attributes['class'].nil?
					node['class'] = node.attributes['class'].value.split(/ /).select{ |cn| 
						cssSelectors.include?('.' + cn) || classesToKeep.include?(cn) || classesToKeep.include?('.' + cn)
					}.join(" ")
					if(node.attributes['class'].value == "")
						node.attributes['class'].remove
					end
				end
				File.open(htmlFile, "w") do |fp|
					fp.puts htmlDoc.to_s
				end
			end
		end
	end
end