#
# Be sure to run `pod lib lint ETSegmentedView.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "ETSegmentedView"
  s.version          = "0.1.0"
  s.summary          = "Synchronous & lightweight segmented view powered by pop framework (facebook)"
  s.description      = <<-DESC
                        #ETSegmentedView

                       ETSegmentedView is a lightweight and synchronous custom segmented view for iOS platform. It's an easy-to-setup and fully customizable component.

                        [![Version](https://img.shields.io/cocoapods/v/ETSegmentedView.svg?style=flat)](http://cocoapods.org/pods/ETSegmentedView)
                        [![License](https://img.shields.io/cocoapods/l/ETSegmentedView.svg?style=flat)](http://cocoapods.org/pods/ETSegmentedView)
                        [![Platform](https://img.shields.io/cocoapods/p/ETSegmentedView.svg?style=flat)](http://cocoapods.org/pods/ETSegmentedView)

                        ![](segmented_clip.gif)

                        ##Dependencies
                        ETSegmentedView has a cocoapod dependency to [POP](https://github.com/facebook/pop) animation framework by facebook.
                       DESC
  s.homepage         = "https://github.com/ersentekin/ETSegmentedView"
  s.screenshots     = "http://i.imgur.com/EbJ4hEg.png", "http://i.imgur.com/BTl5msf.png"
  s.license          = 'MIT'
  s.author           = { "Ersen Tekin" => "ersen.tekin@gmail.com" }
  s.source           = { :git => "https://github.com/ersentekin/ETSegmentedView.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/ersentekin'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'ETSegmentedView' => ['Pod/Assets/*.png']
  }

  s.dependency 'pop', '~> 1.0'
end
