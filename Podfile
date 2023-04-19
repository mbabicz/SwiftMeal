use_modular_headers!

platform :ios, '15.0'

target 'SwiftMeal' do
  use_frameworks!

  pod 'Firebase/Core'
  pod 'Firebase/Auth' 
  pod 'Firebase/Firestore'
  pod 'FirebaseFirestoreSwift'

  target 'SwiftMealTests' do
    inherit! :search_paths
    pod 'Firebase/Core'
    pod 'Firebase/Auth' 
    pod 'Firebase/Firestore'
    pod 'FirebaseFirestoreSwift'
  end

  target 'SwiftMealUITests' do
    pod 'Firebase/Core'
    pod 'Firebase/Auth' 
    pod 'Firebase/Firestore'
    pod 'FirebaseFirestoreSwift'
  end
end

post_install do |installer|
    installer.generated_projects.each do |project|
          project.targets.each do |target|
              target.build_configurations.each do |config|
                  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
               end
          end
   end
end