Pod::Spec.new do |s|
  s.name = "StorybookUI"
  s.version = "1.4.0"
  s.summary = "StorybookUI"

  s.homepage = "https://github.com/eure/Storybook-ios"
  s.license = "MIT"
  s.author = "Eureka, Inc."
  s.source = { :git => "https://github.com/eure/Storybook.git", :tag => s.version }

  s.source_files = ["StorybookUI/**/*.swift"]

  s.module_name = s.name
  s.requires_arc = true
  s.ios.deployment_target = "11.0"
  s.ios.frameworks = ["UIKit"]
  s.dependency "StorybookKit", ">= 1.3.0"
  s.swift_version = "5.3"
end
