#
#  Be sure to run `pod spec lint Saiha.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|
    
  spec.name         = "Saiha"
  spec.version      = "0.1.21"
  spec.summary      = "My iOS universal code."
  spec.homepage     = "https://github.com/Otsuha/Saiha.git"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author             = { "otsuha" => "grass.ichika@gmail.com" }
  spec.source       = { :git => "https://github.com/Otsuha/Saiha.git", :tag => "#{spec.version}" }
  
  spec.ios.deployment_target = "10.0"
  spec.swift_version = "5.0"
  spec.prefix_header_contents = '#import <Saiha/Saiha-Swift.h>'
  
  spec.subspec 'SHFoundation' do |ss|
      ss.source_files = 'Saiha/Classes/SHFoundation/**/*'
      ss.frameworks = "Foundation"
  end
  
  spec.subspec 'SHCommon' do |ss|
      ss.source_files = 'Saiha/Classes/SHCommon/**/*'
      ss.frameworks = "Foundation"
      ss.dependency 'Saiha/SHFoundation'
  end
  
  spec.subspec 'SHUIKit' do |ss|
      ss.source_files = 'Saiha/Classes/SHUIKit/**/*'
      ss.frameworks = "Foundation", "UIKit"
      ss.dependency 'Saiha/SHFoundation'
      ss.dependency 'Saiha/SHCommon'
      ss.dependency 'SDWebImage'
      ss.dependency 'SnapKit'
  end

  spec.subspec 'SHView' do |ss|
      ss.source_files = 'Saiha/Classes/SHView/*'
      ss.frameworks = "Foundation", "UIKit"
      ss.dependency 'Saiha/SHFoundation'
      ss.dependency 'Saiha/SHCommon'
      ss.dependency 'Saiha/SHUIKit'
      ss.dependency 'SDWebImage'
      ss.dependency 'SnapKit'
  end
      
  spec.subspec 'SHContentSheet' do |ss|
      ss.source_files = 'Saiha/Classes/SHContentSheet/*'
      ss.frameworks = "Foundation", "UIKit"
      ss.dependency 'Saiha/SHFoundation'
      ss.dependency 'Saiha/SHCommon'
      ss.dependency 'Saiha/SHUIKit'
      ss.dependency 'SnapKit'
  end
  
  spec.subspec 'SHAlertView' do |ss|
      ss.source_files = 'Saiha/Classes/SHAlertView/*'
      ss.frameworks = "Foundation", "UIKit"
      ss.dependency 'Saiha/SHFoundation'
      ss.dependency 'Saiha/SHCommon'
      ss.dependency 'Saiha/SHUIKit'
      ss.dependency 'SnapKit'
  end
  
  spec.subspec "Resources" do |subspec|
      subspec.resource_bundles = {
          "Saiha" => ["Saiha/Assets/*.xcassets"]
      }
  end

  spec.static_framework = true

end
