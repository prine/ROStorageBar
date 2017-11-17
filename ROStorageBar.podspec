#
# Be sure to run `pod lib lint ROStorageBar.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |spec|
    spec.name         = 'ROStorageBar'
    spec.version      = '2.1.3'
    spec.license      = { :type => 'MIT' }
    spec.homepage     = 'https://github.com/prine/ROStorageBar'
    spec.authors      = { 'Robin Oster' => 'prine.dev@gmail.com' }
    spec.summary      = 'Dynamic Storage Bar (a là iTunes Usage Bar) written in Swift'
    spec.source       = { :git => 'https://github.com/prine/ROStorageBar.git', :tag => '2.1.3' }
    spec.source_files = 'Source/**/*'
    spec.framework    = 'SystemConfiguration'
    spec.ios.deployment_target  = '8.4'
end
