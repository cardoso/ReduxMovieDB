# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'ReduxMovieDB' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  inhibit_all_warnings!

  # Redux pods
  pod 'ReSwift'
  pod 'ReSwiftThunk'

  # Reactive pods
  pod 'RxSwift', '~> 5'
  pod 'RxCocoa', '~> 5'
  pod 'RxKeyboard'

  # Networking pods
  pod 'Nuke', '~> 7.4'

  # Diffing pods
  pod 'DifferenceKit/UIKitExtension'

  target 'ReduxMovieDBTests' do
    inherit! :search_paths
    # Pods for testing
  end

end
