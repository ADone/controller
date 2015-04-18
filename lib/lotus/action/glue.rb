module Lotus
  module Action
    # Glue code for full stack Lotus applications
    #
    # This includes missing rendering logic that it makes sense to include
    # only for web applications.
    #
    # @api private
    # @since 0.3.0
    module Glue
      # Rack environment key that indicates where the action instance is passed
      #
      # @api private
      # @since 0.3.0
      ENV_KEY = 'lotus.action'.freeze

      # @api private
      # @since 0.3.2
      ADDITIONAL_HTTP_STATUSES_WITHOUT_BODY = Set.new([301, 302]).freeze

      # Override Ruby's Module#included
      #
      # @api private
      # @since 0.3.0
      def self.included(base)
        base.class_eval { expose(:format) if respond_to?(:expose) }
      end

      # Check if the current HTTP request is renderable.
      #
      # It verifies if the verb isn't HEAD and if the status demands to omit
      # the body.
      #
      # @return [TrueClass,FalseClass] the result of the check
      #
      # @api private
      # @since 0.3.2
      def renderable?
        !_requires_no_body? &&
          !sending_file?    &&
          !ADDITIONAL_HTTP_STATUSES_WITHOUT_BODY.include?(@_status)
      end

      protected
      # Put the current instance into the Rack environment
      #
      # @api private
      # @since 0.3.0
      #
      # @see Lotus::Action#finish
      def finish
        super
        @_env[ENV_KEY] = self
      end
    end
  end
end
