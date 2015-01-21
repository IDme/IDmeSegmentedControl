 Pod::Spec.new do |s|
  s.name         = "IDmeSegmentedControl"
  s.version      = "0.1.0"
  s.summary      = "An alternative UISegmentedControl that supports showing a second UILabel object in every segment."
  s.homepage     = "https://github.com/idme/IDmeSegmentedControl"
  s.platform     = :ios, '5.0'  
  s.source       = { :git => "https://github.com/idme/IDmeSegmentedControl.git", :tag => "0.1.0" }
  s.source_files = 'IDmeSegmentedControl/*.{h,m}'
  s.requires_arc = true
  s.author       = { "Arthur Ariel Sabintsev" => "arthur@sabintsev.com" }
  s.license      = 'MIT'
 end
