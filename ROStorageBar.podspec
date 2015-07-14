#
# Be sure to run `pod lib lint ROStorageBar.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
s.name             = "ROStorageBar"
s.version          = "1.0.3"
s.summary          = "Dynamic Storage Bar (a là iTunes Usage Bar) written in Swift"
s.description      = <<-DESC
ROStorageBar is a library which provides an easy way to create an UIView which looks
similar like the iTunes Usage Bar.
DESC
s.homepage         = "https://github.com/prine/ROStorageBar"
s.screenshots     = "https://camo.githubusercontent.com/54ac217836c172791733d1464e805a7401db3dea/687474703a2f2f7072696e652e63682f2f524f53746f726167654261722e706e67", "https://camo.githubusercontent.com/62c5d8ec8583b876d890236c4c6784e1ef54422b/687474703a2f2f7072696e652e63682f2f524f53746f726167654261725f63617074696f6e2e706e67"
s.license          = 'MIT'
s.author           = { "Robin Oster" => "robin.oster@rascor.com" }
s.source           = { :git => "https://github.com/prine/ROStorageBar.git", :tag => s.version.to_s }
s.social_media_url = 'https://twitter.com/prinedev'

s.platform     = :ios, '8.0'
s.requires_arc = true

s.source_files = 'Source/**/*'
s.resource_bundles = {
'ROStorageBar' => ['Pod/Assets/*.png']
}

# s.public_header_files = 'Pod/Classes/**/*.h'
# s.frameworks = 'UIKit', 'MapKit'
# s.dependency 'AFNetworking', '~> 2.3'
end
