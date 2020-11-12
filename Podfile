# Uncomment the next line to define a global platform for your project
platform :ios, '14.0’

# Comment the next line if you're not using Swift and don't want to use dynamic frameworks
use_frameworks!

# Comment the next line if you want the compiler to throw warnings regarding the Pods implementation
inhibit_all_warnings!

$alamofire_version = '4.9.1'

def app_pods
  pod 'Alamofire', $alamofire_version
4end

  # Pods for ios-Technical-Test
target 'ios-Technical-Test' do
  app_pods
end

target 'ios-Technical-TestTests' do
  inherit! :search_paths
  app_pods
end

target 'ios-Technical-TestUITests' do
  inherit! :search_paths
  app_pods
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '5.0'
    end
  end
end
