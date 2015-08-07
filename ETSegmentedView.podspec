Pod::Spec.new do |s|
  s.name             = "ETSegmentedView"
  s.version          = "0.2.2"
  s.summary          = "Synchronous & lightweight segmented view -animated with POP!-"
  s.description      = <<-DESC
                        #ETSegmentedView

                        ETSegmentedView is a lightweight and synchronous custom segmented view for iOS platform. It's an easy-to-setup and fully customizable component.

                        ##Dependencies
                        ETSegmentedView depends on the [POP](https://github.com/facebook/pop) animation framework by facebook.
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

  s.dependency 'pop', '~> 1.0.7'
end
