module Ans
  module Generator
    class Railtie < Rails::Railtie

      initializer "ans-generator.append-template-paths" do
        generators = config.respond_to?(:app_generators) ? config.app_generators : config.generators
        generators.templates.unshift File::expand_path('../../templates', __FILE__)
      end

    end
  end
end
