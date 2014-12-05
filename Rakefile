# Rakefile for stream   -*- ruby -*-

begin
  require 'rubygems'
rescue Exception
  nil
end
require 'rake/clean'
require 'rake/testtask'
require 'rdoc/task'
require 'rubygems/package_task'

# Determine the current version of the software

if `ruby -Ilib -rstream -e'puts STREAM_VERSION'` =~ /\S+$/
  PKG_VERSION = $&
else
  PKG_VERSION = "0.0.0"
end

SUMMARY = "Stream - Extended External Iterators"
SRC_RB = FileList['lib/*.rb']

# The default task is run if rake is given no explicit arguments.

desc "Default Task"
task :default => :test

# Define a test task.

Rake::TestTask.new { |t|
  t.libs << "tests"
  t.pattern = 'tests/Test*.rb'
  t.verbose = true
}

task :test

# Define a test that will run all the test targets.
desc "Run all test targets"
task :testall => [:test ]

# Install stream using the standard install.rb script.

desc "Install the application"
task :install do
  ruby "install.rb"
end

# Create a task to build the RDOC documentation tree.

rd = Rake::RDocTask.new("rdoc") { |rdoc|
  rdoc.rdoc_dir = 'stream'
#  rdoc.template = 'kilmer'
#  rdoc.template = 'css2'
  rdoc.title    = SUMMARY
  rdoc.options << '--line-numbers' << '--inline-source' <<
     '--main' << 'README'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/*.rb', 'doc/**/*.rdoc')
}

# ====================================================================
# Create a task that will package the stream software into distributable
# tar, zip and gem files.

PKG_FILES = FileList[
  'install.rb',
  '[A-Z]*',
  'lib/**/*.rb',
  'test/**/*.rb',
  'examples/**/*'
]

if ! defined?(Gem)
  puts "Package Target requires RubyGEMs"
else
  spec = Gem::Specification.new do |s|

    #### Basic information.

    s.name = 'stream'
    s.version = PKG_VERSION
    s.platform = Gem::Platform::RUBY
    s.summary = "Stream - Extended External Iterators"
    s.description = <<-EOF
      Module Stream defines an interface for external iterators.
    EOF

    #### Dependencies and requirements.

    #s.add_dependency('log4r', '> 1.0.4')
    #s.requirements << ""

    #### Which files are to be included in this gem?  Everything!  (Except CVS directories.)

    s.files = PKG_FILES.to_a

    #### C code extensions.

    #s.extensions << "nothing.rb"

    #### Load-time details: library and application (you will need one or both).

    s.require_path = 'lib'                         # Use these for libraries.
    s.autorequire = 'stream'

    #### Documentation and testing.

    s.has_rdoc = true
    s.extra_rdoc_files = ['README']
    s.rdoc_options <<
      '--title' <<  SUMMARY
      '--main' << 'README' <<
      '--line-numbers'

    #### Author and project details.
    s.author = "Horst Duchene"
    s.email = "hd.at.clr@hduchene.de"
    s.homepage = "rgl.rubyforge.org"
    s.rubyforge_project = "rgl"
  end

end

# Misc tasks =========================================================

def count_lines(filename)
  lines = 0
  codelines = 0
  open(filename) { |f|
    f.each do |line|
      lines += 1
      next if line =~ /^\s*$/
      next if line =~ /^\s*#/
      codelines += 1
    end
  }
  [lines, codelines]
end

def show_line(msg, lines, loc)
  printf "%6s %6s   %s\n", lines.to_s, loc.to_s, msg
end

desc "Count lines in the main files"
task :lines do
  total_lines = 0
  total_code = 0
  show_line("File Name", "LINES", "LOC")
  SRC_RB.each do |fn|
    lines, codelines = count_lines(fn)
    show_line(fn, lines, codelines)
    total_lines += lines
    total_code  += codelines
  end
  show_line("TOTAL", total_lines, total_code)
end

ARCHIVEDIR = '/mnt/flash'

desc "Create archives (tgz, zip, gem)"
task :archive => [:package] do
  cp FileList["pkg/*.tgz", "pkg/*.zip", "pkg/*.gem"], ARCHIVEDIR
end

desc "Copy rdoc html to rubyforge"
task :rdoc2rf => [:rdoc] do
  sh "scp  -r stream monora@rubyforge.org:/var/www/gforge-projects/rgl"
end
