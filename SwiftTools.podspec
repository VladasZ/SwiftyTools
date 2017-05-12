Pod::Spec.new do |s|
s.name           = 'SwiftTools'
s.version        = '0.1.7
'
s.summary        = "Swift tools kit to make your life easier."
s.homepage       = "https://github.com/VladasZ/SwiftTools"
s.author         = { 'Vladas Zakrevskis' => '146100@gmail.com' }
s.source         = { :git => 'https://github.com/VladasZ/SwiftTools.git', :tag => s.version }
s.ios.deployment_target = '8.0'
s.source_files   = 'Sources/**/*.swift'
s.license        = 'MIT'
end
