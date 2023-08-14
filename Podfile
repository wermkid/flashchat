platform :ios, '13.0'

target 'Flash Chat iOS13' do
  use_frameworks!
  post_install do |pi|
    pi.pods_project.targets.each do |t|
      t.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
        config.build_settings['CLANG_WARN_QUOTED_INCLUDE_IN_FRAMEWORK_HEADER'] = 'NO'
      end
    end
  end
  pod 'CLTypingLabel','~> 0.4.0'
  pod 'FirebaseAuth'
  pod 'FirebaseFirestore'
end
