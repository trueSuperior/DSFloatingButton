Pod::Spec.new do |s|
  s.name             = 'DSFloatingButton'
  s.version          = '0.1.0'
  s.summary          = 'Easy to create diffuse shadow effect button for iOS.'
  s.swift_version    = '4.2.1'
  s.homepage         = 'https://github.com/trueSuperior/DSFloatingButton'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'UMA' => 'trueSuperiorDev@gmail.com' }
  s.source           = { :git => 'https://github.com/trueSuperior/DSFloatingButton.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/trueSuperior'
  s.ios.deployment_target = '8.0'
  s.source_files = 'DSFloatingButton/Classes/**/*'
end
