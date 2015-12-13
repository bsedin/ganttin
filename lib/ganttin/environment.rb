module Ganttin
  module Environment
    class << self
      def root
        File.expand_path('../../../', __FILE__)
      end

      def dummy_path
        File.join(root, 'spec', 'dummy')
      end
    end
  end
end
