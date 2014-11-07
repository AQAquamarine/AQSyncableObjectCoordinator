Pod::Spec.new do |s|
  s.name         = "AQSyncableObjectCoordinator"
  s.version      = "0.1.0"
  s.summary      = "[iOS] A set of helpers for Aquasync"
  s.homepage     = "https://github.com/AQAquamarine/AQSyncableObjectCoordinator"
  s.license      = "MIT"
  s.author       = { "kaiinui" => "lied.der.optik@gmail.com" }
  s.source       = { :git => "https://github.com/AQAquamarine/AQSyncableObjectCoordinator.git", :tag => "v0.1.0" }
  s.source_files  = "AQSyncableObjectCoordinator/Classes/**/*.{h,m}"
  s.requires_arc = true
  s.platform = "ios", '7.0'
  s.dependency "AQSDictionarySerialization"
end