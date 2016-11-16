# Uncomment this line to define a global platform for your project
# platform :ios, ’10.0’

target 'WorkingManagement' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for WorkingManagement
  pod 'ChameleonFramework/Swift',
  :git => 'https://github.com/ViccAlexander/Chameleon.git',
  :branch => 'swift3'

  pod 'SwiftDate',
  :git => 'https://github.com/malcommac/SwiftDate.git'

  pod 'SnapKit', '~> 3.0.2'

  pod 'JTAppleCalendar',
  :git => 'https://github.com/patchthecode/JTAppleCalendar.git',
  :branch => 'Swift3'

  pod 'FoldingTabBar', '~> 1.1'

  target 'WorkingManagementTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'WorkingManagementUITests' do
    inherit! :search_paths
    # Pods for testing
  end

  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['SWIFT_VERSION'] = '3.0'
      end
    end
  end

end
