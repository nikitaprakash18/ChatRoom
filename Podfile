# Uncomment the next line to define a global platform for your project
platform :ios, "11.0"

target 'Chat' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  pod 'Charts'
  pod 'MessageKit'
  pod 'Firebase/Core'
  pod 'Firebase/Auth'
  pod 'FirebaseStorage'
  pod 'Firebase/Firestore'
  post_install do |installer|
      installer.pods_project.targets.each do |target|
          if target.name == 'MessageKit'
              target.build_configurations.each do |config|
                  config.build_settings['SWIFT_VERSION'] = '4.0'
              end
          end
      end
  end
end