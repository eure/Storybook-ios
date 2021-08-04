Pod::Spec.new do |s|
  s.name = "StorybookKit"
  s.version = "1.8.1"
  s.summary = "StorybookKit"

  s.homepage = "https://github.com/eure/Storybook-ios"
  s.license = "MIT"
  s.author = "Eureka, Inc."
  s.source = { :git => "https://github.com/eure/Storybook.git", :tag => s.version }

  s.source_files = ["StorybookKit/**/*.swift"]

  s.module_name = s.name
  s.requires_arc = true
  s.ios.deployment_target = "10.0"
  s.ios.frameworks = ["UIKit"]
  s.swift_version = "5.3"
end
