module RuboCop
  module Cop
    module MemoryManagement
      # Checks for instances of unpaired resource initialization and closing.
      #
      # Configuration example:
      #
      # MemoryManagement/UnpairedResource:
      #   Raylib:
      #     init_audio_device: close_audio_device
      #     begin_drawing: end_drawing
      #     ...
      #
      class UnpairedResource < Base
        def on_send(node)
          pairs.each do |init_method, close_method|
            if node.method?(init_method) && !paired?(node, close_method)
              msg = "Found `#{node.method_name}` without a corresponding `#{close_method}`."
              add_offense(node, message: msg)
            end
          end
        end

        private

        def pairs
          cop_config['Pairs'] || {}
        end

        def paired?(init_node, close_method)
          processed_source.ast.each_node(:send).find do |node|
            node.method?(close_method) && node.source_range.begin_pos > init_node.source_range.begin_pos
          end
        end
      end
    end
  end
end
