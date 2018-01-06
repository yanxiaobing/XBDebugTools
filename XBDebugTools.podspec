Pod::Spec.new do |s|
    s.name         = 'XBDebugTools'
    s.version      = '1.0.9'
    s.summary      = 'Catch Crash Exception And Collect Api Info'
    s.homepage     = 'https://github.com/yanxiaobing/XBDebugTools'
    s.license      = 'MIT'
    s.authors      = {'XBingo' => 'dove025@qq.com'}
    s.platform     = :ios, '8.0'
    s.source       = {:git => 'https://github.com/yanxiaobing/XBDebugTools.git', :tag => s.version}
    s.requires_arc = true
    s.source_files     = 'XBDebugTools/**/*.{h,m}'
end