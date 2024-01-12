#
# Be sure to run `pod lib lint DiStorage.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DiStorage'
  s.version          = '0.1.1'
  s.summary          = 'DiStorage is a lightweight dependency injection library for swift.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
DiStorage is a lightweight dependency injection library for swift.
The main advantage is the small amount of code (something like 200 lines).
Therefore, you can look at code and be sure that the program does not contain any back doors and so on.
Also, the library demonstrates what dependency injection is and how similar libraries work.
The latter is important for beginning developers.
                        DESC

  s.homepage         = 'https://github.com/AlexeyYuPopkov/DiStorage_swift'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'AlexeyYuPopkov' => 'alexey.yu.popkov@gmail.com' }
  s.source           = { :git => 'https://github.com/AlexeyYuPopkov/DiStorage_swift.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '12.0'
  s.swift_version = "5.0"
  
  s.source_files = 'DiStorage/Classes/**/*'
  
  # s.resource_bundles = {
  #   'DiStorage' => ['DiStorage/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
