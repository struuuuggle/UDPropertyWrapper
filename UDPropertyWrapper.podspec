Pod::Spec.new do |spec|
  spec.name         = "UDPropertyWrapper"
  spec.version      = "0.0.2"
  spec.summary      = "Yet another type-safed wrapper of UserDefaults implemented with property wrappers"
  spec.homepage     = "https://github.com/struuuuggle/UDPropertyWrapper"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author             = "Mikiya Abe"
  spec.social_media_url   = "https://twitter.com/struuuuggle"
  spec.platform     = :ios
  spec.ios.deployment_target = "13.0"
  spec.osx.deployment_target = "10.15"
  spec.watchos.deployment_target = "6.0"
  spec.tvos.deployment_target = "13.0"
  spec.source       = { :git => "https://github.com/struuuuggle/UDPropertyWrapper.git",
                        :tag => "#{spec.version}" }
  spec.source_files  = "Sources/**/*.swift"
  spec.ios.frameworks = 'Foundation'
  spec.swift_version = "5.3"
end
