#Uncomment this line to define a global platform for your project
platform :ios, '10.0'

target 'Main' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for YiDaIOSSwiftPractices
  pod 'CocoaLumberjack/Swift'

  pod 'SwiftyJSON'
  pod 'Gloss', '~> 1.0'

  pod 'SwiftMessages'

  pod 'SwiftValidators'

   pod 'PySwiftyRegex'

  pod 'RxSwift'
  pod 'RxCocoa'

  pod 'FormValidatorSwift', '~> 1.0'

  pod 'Alamofire', '~> 4.0'

  pod 'pop', '~> 1.0'

  pod 'SnapKit', '~> 3.0'

  def pods_for_test_targets
    pod 'RxBlocking', '~> 3.0'
    pod 'RxTest',     '~> 3.0'
  end

  #target 'MainTests' do
    #inherit! :search_paths

    ##pods_for_test_targets
  #end

  #target 'MainUITests' do
    #inherit! :search_paths
    ## Pods for testing

    ##pods_for_test_targets
  #end

  # Configrue for EarlGrey
  PROJECT_NAME = 'Main'
  TEST_TARGET = 'EarlGreyTests'
  SCHEME_FILE = TEST_TARGET + '.xcscheme'

  target TEST_TARGET do
    inherit! :search_paths

    pod 'EarlGrey'
  end

  post_install do |installer|
    require 'earlgrey'
    configure_for_earlgrey(installer, PROJECT_NAME, TEST_TARGET, SCHEME_FILE, {swift: true})
  end
end
