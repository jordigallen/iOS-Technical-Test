# Uncomment the next line to define a global platform for your project
platform :ios, '14.0'
source 'https://github.com/CocoaPods/Specs.git'

# Comment the next line if you're not using Swift and don't want to use dynamic frameworks
use_frameworks!

# Comment the next line if you want the compiler to throw warnings regarding the Pods implementation
inhibit_all_warnings!

$alamofire_version = '4.9.1'
$nimble_version = '8.0.4'
$promise_kit_version = '6.12.0'
$sdwebimage_version = '5.3.1'
$swiftgen_version = '6.1.0'
$snapshotTesting_version = '1.8.2'
$swinject_version = '2.6.0'
$swinjectStoryboard_version = '2.2.0'

def app_pods
  pod 'Alamofire', $alamofire_version
  pod 'SDWebImage', $sdwebimage_version
  pod 'SwiftGen', $swiftgen_version
  pod 'Swinject', $swinject_version
  pod 'PromiseKit', $promise_kit_version
  pod 'Swinject', $swinject_version
  pod 'SwinjectStoryboard', $swinjectStoryboard_version
end

# Pods for ios-Technical-Test
target 'ios-Technical-Test' do
  app_pods
end

target 'ios-Technical-TestTests' do
  inherit! :search_paths
  app_pods
  pod 'Nimble', $nimble_version
  pod 'SnapshotTesting', $snapshotTesting_version
end

target 'ios-Technical-TestUITests' do
  inherit! :search_paths
  app_pods
  pod 'Swifter', '1.4.7'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    puts target.name
    target.build_configurations.each do |config|
       config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'
    end
  end
end
