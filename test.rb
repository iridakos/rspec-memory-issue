require "rspec/core"
require "memory_profiler"
require "pry-byebug"

i = 0

$memprof = false
$debug = false

Signal.trap("SIGUSR1") do
  $debug = !$debug
end

Signal.trap("SIGPROF") do
  if $memprof
    puts "stopping memprof..."
    MemoryProfiler.stop.pretty_print(
      to_file: "/tmp/memory_profile_#{Process.pid}_#{Time.now.to_i}",
      color_output: true,
      detailed_report: true,
    )

    $memprof = false
  else
    puts "started memprof..."
    MemoryProfiler.start
    $memprof = true
  end
end

puts $$
sleep 5

loop do
  binding.pry if $debug

  puts "run #{i}"
  i += 1

  RSpec.reset
  RSpec.clear_examples
  RSpec.world.reset

  opts = RSpec::Core::ConfigurationOptions.new(["spec/foo_spec.rb"])
  RSpec::Core::Runner.new(opts).run($stderr, $stdout)
end
