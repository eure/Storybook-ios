Pod::Spec.new do |s|
  s.name = "StorybookKitTextureSupport"
  s.version = "1.8.1"
  s.summary = "StorybookKitTextureSupport"

  s.homepage = "https://github.com/eure/Storybook-ios"
  s.license = "MIT"
  s.author = "Eureka, Inc."
  s.source = { :git => "https://github.com/eure/Storybook.git", :tag => s.version }

  s.source_files = ["StorybookKitTextureSupport/**/*.swift"]

  s.module_name = s.name
  s.requires_arc = true
  s.ios.deployment_target = "11.0"
  s.ios.frameworks = ["UIKit"]
  s.swift_version = "5.3"
  s.dependency "StorybookKit", ">= 1.7.0"
  s.dependency "Texture/Core", ">= 3.0.0"
  s.dependency "TextureBridging", ">= 3.0.1"
  s.dependency "TextureSwiftSupport", ">= 3.9.0"
end
