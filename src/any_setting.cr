require "yaml"
require "ecr/macros"

class AnySetting
  property source, namespace, content

  macro source(path)
    source = {{path}}
    content = IO::Memory.new.tap { |io| ECR.embed {{path}}, io }.to_s
  end

  macro namespace(namespace)
    namespace = {{namespace}}
  end

  macro mapping(**properties)
    YAML.mapping({{properties}})
  end

  macro load
    yaml = namespace ? YAML.parse(content)[namespace].to_yaml : content
    {{@type}}.from_yaml yaml
  end
end
