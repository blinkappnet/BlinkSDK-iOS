Pod::Spec.new do |s|
  s.name             = 'BlinkSDK'
  s.version          = '0.1.0'
  s.summary          = 'An SDK for accident detection and driver behavior analysis.'
  
  s.description      = <<-DESC
  BlinkSDK provides a comprehensive solution for monitoring and analyzing driving behavior, as well as detecting accidents in real-time. Designed for seamless integration with iOS applications, it leverages advanced algorithms to track and evaluate driver actions, enabling proactive safety measures and detailed behavior insights. Ideal for developers aiming to enhance driving safety features within their apps, BlinkSDK offers robust tools for accident detection and performance analytics.
                       DESC

  s.homepage         = 'https://blinkapp.net'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'BlinkApp LLC' => 'info@blinkapp.net' }
  s.source           = { :git => 'https://github.com/blinkappnet/BlinkSDK-iOS.git', :tag => s.version.to_s }
    
  s.swift_version = '5.0'
  s.ios.deployment_target = '13.0'
  s.ios.vendored_frameworks = [
    "Framework/BlinkSDK.xcframework",
  ]
  s.dependency 'TensorFlowLiteSwift'


end
