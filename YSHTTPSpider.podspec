#
# Be sure to run `pod lib lint YSBase.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
s.name             = 'YSHTTPSpider'
s.version          = '0.1.0'
s.summary          = 'WTYS YSHTTPSpider.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

s.description      = 'WTYS YSHTTPSpider 网络库.'

s.homepage         = 'https://git.dev.tencent.com/manfengjun/YSHTTPSpider.git'
# s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'liufengjun' => 'liufengjun@chinawutong.com' }
s.source           = { :git => 'https://git.dev.tencent.com/manfengjun/YSHTTPSpider.git', :tag => s.version.to_s }

s.ios.deployment_target = '9.0'

s.source_files = 'YSHTTPSpider/Classes/**/*'

# s.resource_bundles = {
#   'YSBase' => ['YSHTTPSpider/Assets/*.png']
# }

# s.public_header_files = 'Pod/Classes/**/*.h'
s.frameworks = 'UIKit'
s.dependency 'Alamofire'
s.dependency 'HandyJSON'
end
