
Pod::Spec.new do |spec|


  spec.name         = "JobsIM"
  spec.version      = "0.0.1"
  spec.summary      = "即时聊天通讯UI"
  spec.description  = "即时聊天通讯"

  spec.homepage     = "https://github.com/295060456/JobsIM"
  # spec.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"
  spec.license      = "MIT"

  spec.author             = { "Jobs" => "lg295060456@gmail.com" }

  spec.platform     = :ios, "5.0"

  spec.ios.deployment_target = "14.1"

  spec.source       = { :git => "https://github.com/295060456/JobsIM.git", :tag => "#{spec.version}" }


  spec.source_files  = "JobsIMComponent/*.{h,m}"

  spec.public_header_files = "JobsIMComponent/JobsIMComponent.h"

  # spec.resource  = "icon.png"
  # spec.resources = "Resources/*.png"

  # spec.preserve_paths = "FilesToSave", "MoreFilesToSave"

  # spec.framework  = "SomeFramework"
  # spec.frameworks = "SomeFramework", "AnotherFramework"

  # spec.library   = "iconv"
  # spec.libraries = "iconv", "xml2"
  spec.requires_arc = true

  # spec.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # spec.dependency "JSONKit", "~> 1.4"

end
