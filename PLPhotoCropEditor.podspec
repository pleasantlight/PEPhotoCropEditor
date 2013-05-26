Pod::Spec.new do |s|
  s.name         = "PLPhotoCropEditor"
  s.version      = "1.0.0"
  s.summary      = "Image cropping library for iOS, similar to the Photos.app UI."
  s.homepage     = "https://github.com/pleasantlight/PLPhotoCropEditor"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Noam Etzion-Rosenberg" => "noam@pleasantlight.com" }
  s.authors      = { "Noam Etzion-Rosenberg" => "noam@pleasantlight.com" }
  s.source       = { :git => "https://github.com/pleasasntlight/PLPhotoCropEditor.git", :tag => "v1.0.0" }
  s.ios.deployment_target = '5.0'
  s.source_files = 'Lib/*'
  s.resources = "Resources/*.png"
  s.framework  = 'QuartzCore', 'AVFoundation'
  s.requires_arc = true
end
