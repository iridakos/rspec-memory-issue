module RSpec
  module Core
    class World
      def reset
        RSpec::ExampleGroups.remove_all_constants
        example_groups.clear
        @sources_by_path.clear if defined?(@sources_by_path)
        @syntax_highlighter = nil
        @example_group_counts_by_spec_file = Hash.new(0)
        @filtered_examples.clear
        RSpec::Core::AnonymousExampleGroup.examples.clear
        RSpec::Core::AnonymousExampleGroup.children.clear
        shared_example_group_registry.reset
      end
    end

    module SharedExampleGroup
      class Registry
        def reset
          shared_example_groups.delete_if { |k, _| k != :main }
        end
      end
    end
  end
end
