require "yaml"

class AnySetting
  property source, namespace, content

  macro source(path)
    source = {{path}}
  end

  macro namespace(namespace)
    namespace = {{namespace}}
  end

  macro mapping(**properties)
    YAML.mapping({{properties}})
  end

  macro load
    content = File.read(source)
    yaml = namespace ? YAML.parse(content)[namespace].to_yaml : content
    {{@type}}.from_yaml yaml
  end
end
