Gem::Specification.new do |spec|
  spec.name = "studio_game_zandster"
  spec.version = "1.0.0"
  spec.license = "MIT"
  spec.author = "zandster"
  spec.email = "zandra630@gmail.com"
  spec.summary = "A command-line game of chance and treasure."

  spec.files = Dir["{bin,lib}/**/*"] + %w[LICENSE.txt README.md]
  spec.executables = ["studio_game"]

  spec.required_ruby_version = ">=3.2.0"

end