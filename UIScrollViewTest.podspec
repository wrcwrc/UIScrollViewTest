Pod::Spec.new do |s|
s.name = "UIScrollViewTest"
s.version = "1.0.0"
s.ios.deployment_target = '8.0'
s.summary = "测试支持cocoapod"
s.homepage = "https://github.com/wrcwrc/UIScrollViewTest"
s.license = { :type => "MIT", :file => "LICENSE" }
s.author = { "wrcwrc" => "760480765@qq.com" }
s.source = { :git => "https://github.com/wrcwrc/UIScrollViewTest.git", :tag => "#{s.version}" }
s.source_files =  'UIScrollViewTest/*.{h,m}'
s.requires_arc = true
end
