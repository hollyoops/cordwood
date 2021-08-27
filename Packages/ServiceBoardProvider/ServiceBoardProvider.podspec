#
# Be sure to run `pod lib lint ServiceBoardProvider.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ServiceBoardProvider'
  s.version          = '0.1.0'
  s.summary          = 'A short description of ServiceBoardProvider.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/hcli@thoughtworks.com/ServiceBoardProvider'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'hcli@thoughtworks.com' => 'hcli@thoughtworks.com' }
  s.source           = { :git => 'https://github.com/hcli@thoughtworks.com/ServiceBoardProvider.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '13.0'
  s.source_files = 'Sources/**/*'

  s.dependency 'ServiceBoard'
  s.dependency 'Analytics'
  s.dependency 'ServiceContracts'
  s.dependency 'Message'
  s.dependency 'Main'

  s.script_phase = {:name => 'CodeGen for Service Discover', :script => 'ruby ${SRCROOT}/../CodeGen.rb --configPath=${SRCROOT}/.. --template=${PODS_TARGET_SRCROOT}/Templates/connectServices.stencil --output=${PODS_TARGET_SRCROOT}/Sources/__generated__/DiscoveredServices.generated.swift', :execution_position => :before_compile }

  # s.resource_bundles = {
  #   'ServiceBoardProvider' => ['ServiceBoardProvider/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
